OZC = ozc
OZENGINE = ozengine

DBPATH= databaseTest.txt
NOGUI= "--nogui" #"--nogui" # set this variable to --nogui if you don't want the GUI
ANSPATH= test_answers.txt

SRC=$(wildcard *.oz)
OBJ=$(SRC:.oz=.ozf)

OZFLAGS = --nowarnunused

all: $(OBJ)

runSE: all
	@echo RUN mainSansExtensions.ozf
	@$(OZENGINE) mainSansExtensions.ozf --db $(DBPATH) $(NOGUI) --ans $(ANSPATH)

runAE: all
	@echo RUN mainAvecExtensions.ozf
	@$(OZENGINE) mainAvecExtensions.ozf --db $(DBPATH) $(NOGUI) --ans  $(ANSPATH)

%.ozf: %.oz
	@echo OZC $@
	@$(OZC) $(OZFLAGS) -c $< -o $@

.PHONY: clean

clean:
	@echo rm $(OBJ)
	@rm -rf $(OBJ)
