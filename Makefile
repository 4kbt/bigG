OCT:= octave -p mlib


PLOTINPUTS:= BootstrapResult.dat BirgeRatioedTraditionalAverage.dat BootstrapHistogram.dat
CODATA:= CODATABootstrapComparison


all : $(CODATA).eps 

$(PLOTINPUTS) : bigGBootstrap.m codata.dat mlib/*
	$(OCT) bigGBootstrap.m

$(CODATA).eps: $(CODATA).gpl $(PLOTINPUTS) codata.dat CODATA2010Recommendation.dat
	gnuplot $(CODATA).gpl
