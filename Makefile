BINARY = build/rpn_main
INSTALL_DIR = ~/.local/bin
INSTALL_EXE_NAME = rpn

.PHONY: $(BINARY)
$(BINARY):
	gprbuild

.PHONY: install
install: $(BINARY)
	cp $(BINARY) $(INSTALL_DIR)/$(INSTALL_EXE_NAME)

.PHONY: run
run: $(BINARY)
	@echo -----------------------
	@echo starting $(BINARY)
	@echo -----------------------
	@$(BINARY)
