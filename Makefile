CHANGE_CONTACT_TOOL="./change_contact_details.sh"
SOURCE="Nilton_Moura-Resume.tex"

resume:
	$(CHANGE_CONTACT_TOOL) true && pdflatex $(SOURCE) && $(CHANGE_CONTACT_TOOL) false

clean:
	rm *aux *log *out
