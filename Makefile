DIR =
DOT_DIR = 			fonts local vim nvim
DOT_FILE = 			git-completion.sh gitignore osx ghci tmux.conf \
					tmux-osx.conf \
					tmux-linux.conf vimrc xvimrc nvimrc zshrc zshrc-linux \
					zshrc-osx \
					jshintrc bowerrc
CONFIG_SUBDIR = 	fish

all: preinstall install

install: $(HOME)/.history \
	$(foreach f, $(DIR), install-dir-$(f)) \
	$(foreach f, $(DOT_DIR), install-dotdir-$(f)) \
	$(foreach f, $(DOT_FILE), install-file-$(f)) \
	$(foreach f, $(CONFIG_SUBDIR), install-config-subdir-$(f))

preinstall:
	@echo "  MKDIR creating ~/.config"
	@mkdir -p $(HOME)/.config

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

install-config-subdir-%: $(CURDIR)/config/%
	@echo "  LN  config/$* to ~/.config/$*"
	@ln -sf $(CURDIR)/config/$* $(HOME)/.config/$*

clean: $(foreach f, $(DIR), clean-$(f)) \
	$(foreach f, $(DOT_DIR), clean-.$(f)) \
	$(foreach f, $(DOT_FILE), clean-.$(f)) \
	$(foreach f, $(CONFIG_SUBDIR), cleanconfig-subdir-$(f))

clean-%:
	@echo "  CLEAN  ~/$*"
	@sh -c "if [ -h ~/$* ]; then rm ~/$*; fi"

cleanconfig-subdir-%:
	@echo "  CLEAN  ~/.config/$*"
	@sh -c "if [ -h ~/.config/$* ]; then rm ~/.config/$*; fi"

.PHONY : clean

