OUTPUT = main.md
PARTS  = $(shell cat files.list)
TMP    = .tmp_body.md

$(OUTPUT): $(PARTS)
	@cat $(PARTS) > $(TMP)
	@python3 ~/util/build_md/gen_toc.py $(TMP) > $(OUTPUT)
	@echo "" >> $(OUTPUT)
	@cat $(TMP) >> $(OUTPUT)
	@rm $(TMP)
