# KnightOS SDK targets
.PHONY: all run clean help info package

all: $(ALL_TARGETS)
	@rm -rf $(SDK)root
	@mkdir -p $(SDK)root
	@cp -r $(SDK)pkgroot/* $(SDK)root
	@rm -rf $(SDK)root/include
	@cp -r $(ROOT)* $(SDK)root/
	@cp $(SDK)kernel.rom $(SDK)debug.rom
	@mkdir -p $(SDK)root/etc
	@echo "$(INIT)" > $(SDK)root/etc/inittab
	@$(GENKFS) $(SDK)debug.rom $(SDK)root/ > /dev/null

run: all
	$(EMU) $(EMUFLAGS) $(SDK)debug.rom

debug: all
	$(EMU) $(EMUFLAGS) --debug $(SDK)debug.rom

clean:
	@rm -rf $(OUT)
	@rm -rf $(SDK)root
	@rm -rf $(SDK)debug.rom

package:
	kpack {{ project_name}}.pkg $(BIN)
	
help:
	@echo "KnightOS Makefile for {{ project_name }}"
	@echo "Usage: make [target]"
	@echo ""
	@echo "Common targets:"
	@echo "	all: 		Builds the entire project"
	@echo "	run: 		Builds and runs the project in the debugger"
	@echo "	package:	Builds a KnightOS package"
	@echo "	info:		Lists information about this project"

info:
	@echo "Assembler:		$(AS)"
	@echo "Emulator:		$(EMU)"
	@echo "Include:		$(INCLUDE)"
	@echo "Target Model:		$(TARGET_MODEL)"
