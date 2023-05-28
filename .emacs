  ; Ensure GUI Emacs doesn't fry my eyes
(set-background-color "black")

  ; Change where customizations are saved
(setq-default custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

  ; Load configuration using Org Babel
(package-initialize)
(org-babel-load-file "~/.emacs.d/Emacs.org")
