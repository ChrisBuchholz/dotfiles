# Makefile for dotfiles (cf. https://github.com/pix/dotfiles)

DIR = 		
DOT_DIR = 	fonts local vim iterm2colors
DOT_FILE = 	Xdefaults profile git-completion.sh gitignore \
		inputrc screenrc tmux.conf vimrc osx

all: install

install: $(HOME)/.history $(foreach f, $(DIR), install-dir-$(f)) \
	 $(foreach f, $(DOT_DIR), install-dotdir-$(f)) \
	 $(foreach f, $(DOT_FILE), install-file-$(f))

$(HOME)/.history:
	@echo "  MKDIR Creating ~/.history"
	@mkdir $(HOME)/.history 2>/dev/null

install-dir-%: %
	@echo "  LN  $< to ~/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<

install-dotdir-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -snf $(CURDIR)/$< $(HOME)/.$<

install-file-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -sf $(CURDIR)/$< $(HOME)/.$<

clean: $(foreach f, $(DIR), clean-$(f)) \
       $(foreach f, $(DOT_DIR), clean-.$(f)) \
       $(foreach f, $(DOT_FILE), clean-.$(f))

clean-%:
	@echo "  CLEAN  ~/$*"
	@sh -c "if [ -h ~/$* ]; then rm ~/$*; fi"

.PHONY : clean

