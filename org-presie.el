;;; org-presie.el --- simple presentation with an org file

;; Copyright (C) 2012  Nic Ferrier

;; Author: Nic Ferrier <nferrier@ferrier.me.uk>
;; Maintainer: Nic Ferrier <nferrier@ferrier.me.uk>
;; Created: 26th August 2012
;; Version: 0.0.5
;; Keywords: hypermedia, outlines
;; Package-Requires: ((framesize "0.0.1")(eimp "1.4.0")(org "7.8.09"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is a very simple tool for running an org-file as a
;; presentation.

;;; Commentary on the modifications:

;; Some principles adopted:
;; - Any topic is a presentation topic.
;; - Generaly  will keep only ONE window visible (exception is when an image is displayed0
;; - possible to navigate forward & backward
;; - changed the navigation to arrow left and right (plus ESC arrow)
;; - Each subtree may exceed the display, so it's possible to 
;;   keep going with the cursor, showing the continuation
;; - scales up the face for the presentation mode.
;;
;;  The key bindings:
;;  GLOBAL: <f5> - switch ORG-MODE or ORG-PRES-MODE
;;  MINOR:  right -> next topic OR 5 lines down (recenter)
;;          left  -> previous topic OR 1 line up (recenter)
;;          escape right -> next topic
;;          escape left  -> previous topic
;;; Code:

(require 'org)
(require 'eimp)
(require 'cl)
(define-key global-map [f5] 'org-pres-mode)
(defun org-pres--eimp-fit ()
  "Function used as a hook, fits the image found to the window."
  (when (eq major-mode (quote image-mode))
    (eimp-fit-image-to-window nil)))

(defun org-pres-next ()
  "Next 'line'. Case this line is a topic, change the topic"
  (interactive)
  (beginning-of-line)
  (if (looking-at "^\\*+")
      (progn
	;; Close the previous topic
	(let ((string-actual
	       (buffer-substring (match-beginning 0)(match-end 0))))
	  (save-excursion
	  (forward-line -1)
	  (when (re-search-backward "^\\*+" nil t)
	    (let ((string-previous
		   (buffer-substring (match-beginning 0)(match-end 0))))
	      ;; closes only if previous topic is same level or sub level
	      (if (or (string= string-actual string-previous)(string< string-actual string-previous))
		  (progn (beginning-of-line)
			 (hide-subtree)))
	      (if (string< string-actual string-previous)
		  ;; when the actual topic is a toplevel, garantee the previous top-level will be closed
		  (if (string= string-actual "*")
		      (when (re-search-backward "^\\*[^*]" nil t)
			(beginning-of-line)
			(hide-subtree))))))))
	
	;; continue
	(delete-other-windows)
	;; the two commands is to garantee the topic will
	;; be opened the right way
	(hide-subtree)
        (call-interactively 'org-cycle)
	(save-excursion
	  (let ((next-outline
		 (save-excursion
		   (forward-line)
		   (re-search-forward "^\\*" nil 't))))
	    (when (re-search-forward
		   "\\[\\[.*\\.\\(jpg\\|gif\\|png\\|JPG\\)" next-outline t)
	      (split-window-below) ;; necessary as the image was not resized correctly
	      (org-open-at-point)
	      (other-window -1))))
	(forward-line)
	(recenter)
	)
    ;;else
    ;; we're not at a topic place. So, go down max 5 lines
    ;; or until a new topic if found
    (let ((COUNT 5))
      (while (> COUNT 0)
	(forward-line)
	(if (looking-at "^\\*+") 
	    (setq COUNT 0)
	  (setq COUNT (- COUNT 1)))))
    (recenter)
   )
)
(defun org-pres-next-topic ()
  "Next 'slide'."
  (interactive)
  (if (re-search-forward "^\\*+" nil t)
      (progn 
	(beginning-of-line)
	(org-pres-next))
    ))
(defun org-pres-previous ()
  "Previous 'line'. Case this line is a topic, change the topic"
  (interactive)
  (beginning-of-line)
  (if (looking-at "^\\*+")
      (progn
	;; Fechar o seguinte
	(hide-subtree)
	(forward-line -1)
	(end-of-line)
	(if (re-search-backward "^\\*" nil 't)
	    (progn
	      (org-pres-next)
	      (forward-line -1))))
    ;;else
    (forward-line -1)
    (recenter)
   )
)
(defun org-pres-previous-topic ()
  "Previous 'topic'."
  (interactive)
  (if (re-search-backward "^\\*+" nil t)
      (progn 
	(beginning-of-line)
	(org-pres-previous))
    ))
;;;###autoload
(define-minor-mode org-pres-mode
    "Turn on Org Presentation mode.

Treats a single org file as a list of top level 'slides',
'opening' each one in turn (and closing the previous one).

A positive prefix argument forces this mode on, a negative prefix
argument forces this mode off; otherwise the mode is toggled."
  nil
  "PRES"
  '(
    ([right]   . org-pres-next)
    ([left]    . org-pres-previous)
    ([escape right]   . org-pres-next-topic)
    ([escape left]    . org-pres-previous-topic)
    ([f5]      . org-mode)
    )
  (unless (eq major-mode 'org-mode)
    (error "only works with org-mode!"))
  (visual-line-mode t)
  (add-hook 'find-file-hook 'org-pres--eimp-fit)
  (text-scale-increase 1)
)

(provide 'org-presie)

;;; org-presie.el ends here
