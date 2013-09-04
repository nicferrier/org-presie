<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. Overview</a></li>
<li><a href="#sec-2">2. Installation</a></li>
<li><a href="#sec-3">3. usage</a></li>
<li><a href="#sec-4">4. POST</a>
<ul>
<li><a href="#sec-4-1">4.1. Onde encontrar</a></li>
<li><a href="#sec-4-2">4.2. DISCLAIMER</a></li>
</ul>
</li>
<li><a href="#sec-5">5. Tasks</a>
<ul>
<li><a href="#sec-5-1">5.1. </a></li>
</ul>
</li>
</ul>
</div>
</div>


# Overview

To have a **very simple** presentation tool inside emacs, navigating
through the *org topics*.

It is completely based on **org-presie** (thanks to [Nic Ferrier](nferrier@ferrier.me.uk) who
first created the org-presie)

# Installation

-   copy the file `org-presie.el` into your *el* directory

-   insert into `init.el` the command:
    
    `(require 'org-presie)`
    
    ps: if you have the above file in any other directory, first
    insert this line to your `init.el`:
    
    `(add-to-list 'load-path "~/<directory you have org-presie.el
        file>")`

# usage

In any *org file*, press **<f5>** and it will change to PRES-minor
mode

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col class="left"/>

<col class="left"/>
</colgroup>
<tbody>
<tr>
<td class="left">Key</td>
<td class="left">command</td>
</tr>


<tr>
<td class="left"><f5></td>
<td class="left">toggle PRES minor mode inside an ORG buffer</td>
</tr>


<tr>
<td class="left">right (arrow)</td>
<td class="left">Advance 5 lines or until next topic (any level) - what comes first</td>
</tr>


<tr>
<td class="left">left (arrow)</td>
<td class="left">back one line at a time</td>
</tr>


<tr>
<td class="left">esc-right</td>
<td class="left">Advance to next topic</td>
</tr>


<tr>
<td class="left">esc-left</td>
<td class="left">back to previous topic</td>
</tr>
</tbody>
</table>

# POST

Em busca de uma ferramenta que fizesse apresentações diretamente do
`emacs`, encontrei um post muito interessante:

[How to present using Org-mode in Emacs](http://sachachua.com/blog/2013/04/how-to-present-using-org-mode-in-emacs/)

Em um primeiro momento, foi mais dificil recordar das nuances do
emacs, e ver a solução própria da autora para sua própria
apresentação.

Fui atras do **org-presie**, que me pareceu suficiente para o que
queria, mas em seguida se mostrou insuficiente:

-   Não havia como voltar para *slides* anteriores

-   Não considerava sub-tópicos

-   Não se saia muito bem na estrutura do documento, quando se
    mesclava niveis de tópicos e/ou quando o texto era muito longo.

Solução: Fazer minhas próprias modificações, aproveitando para
matar a saudade dos módulos em emacslisp que fazia para suportar
meus programas em C/C++ (nossa.. faz tempo!!).

O módulo **continua** **BEM SIMPLES**, mas para pequenas conversas com
a turma, é suficiente.

O org-mode ainda permite que, para algo um pouco melhor, se exporte
o mesmo para o `reveal`, ou em outro formato (latex tambem bate uma
saudade&#x2026;)

Já me dou por feliz em ter minha interface em modo texto, fazendo
blocos em caracteres, barras e "+" como esse:


                  +-----------+
                  |           |
                  |   EMACS   |
                  |           |
                 -+-----\-----+--
              --/        \       \----
           --/           |            \---
    +-----/-----+  +------\-----+  +------\------+
    |           |  |            |  |             |
    |           |  |            |  |             |
    |  ORG-MODE |  |PICTURE-MODE|  | ARTIST-MODE |
    |           |  |            |  |             |
    +-----------+  +------------+  +-------------+

Esse *artist-mode* ainda peca por não ter como pegar um retangulo
feito, ou uma reta (um elemento) e modifica-lo (mover,
redimensionar).

Uma vez feito, vira caracter no buffer&#x2026; mas.

## Onde encontrar

O *mode* está disponível no repositório do github:

[meu org-presie](https://github.com/tucasp/org-presie)

## DISCLAIMER

Certamente as modificações feitas estão um pouco longe da elegância
desejada, mas depois de tanto tempo tentar dominar os comandos
existentes e saber qual a melhor forma de fazer suas idéias em um
`emacslisp` seria muita pretenção!

# Tasks

## TODO 
