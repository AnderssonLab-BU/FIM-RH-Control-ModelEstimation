function Pr = Signal_Strength(Pt,d,dr,gamma)

Pr = Pt + K -10*gamma*log10(d/dr);
