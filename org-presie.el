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

;;; Code:

(require 'org)
(require 'eimp)
(require 'cl)

(defun org-pres--eimp-fit ()
  "Function used as a hook, fits the image found to the window."
  (when (eq major-mode (quote image-mode))
    (eimp-fit-image-to-window nil)))

(defun org-pres-next ()
  "Next 'slide'."
  (interactive)
  (if (save-excursion
        (let ((bol (beginning-of-line)))
          (when bol
            (goto-char bol))
        (looking-at "^\\*+")))
      (progn
        (call-interactively 'org-cycle)
        (next-line)
        (show-branches)
        (save-excursion
          (let ((next-outline
                 (save-excursion
                   (next-line)
                   (re-search-forward "^\\*[^*]" nil 't))))
            (when (re-search-forward
                   "\\[\\[.*\\.\\(jpg\\|gif\\|png\\)" next-outline t)
              (org-open-at-point)
              (other-window -1)))))
      (hide-subtree)
      (re-search-forward "^\\*+" nil nil)
      (show-branches)))

;;;###autoload
(define-minor-mode org-pres-mode
    "Turn on Org Presentation mode.

Treats a single org file as a list of top level 'slides',
'opening' each one in turn (and closing the previous one).

A postive prefix argument forces this mode on, a negative prefix
argument forces this mode off; otherwise the mode is toggled."
  nil
  "PRES"
  '(([?\x20]   . org-pres-next))
  (unless (eq major-mode 'org-mode)
    (error "only works with org-mode!"))
  (visual-line-mode t)
  (add-hook 'find-file-hook 'org-pres--eimp-fit))

(provide 'org-presie)

;;; org-presie.el ends here
