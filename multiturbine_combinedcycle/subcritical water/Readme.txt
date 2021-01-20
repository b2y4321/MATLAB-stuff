Basically, what this program does is an extension of the previous programs, which assumed that we took our supercritical fluid and expanded it through our turbine until saturation (which we did only once). In real industry, significant gains are to be had by taking this expanded, saturated liquid, superheating a given number of degr4ees, and repeating the process. This is often done 3 times in power plants and the steam is expanded in 3 cycles, corresponding to a high, a medium, and a low-pressure turbine.

= What we do here is take a fluid (must be subcritical in this case, or the correlations predict everything wrong). We expand this fluid, and reheat it a number of degrees superheat.
- We allow n to be specified, with corresponding to one initial stage and n-1 stages where the exhausted (expanded) fluid is superheated and the process repeats.
- We specify the initial pressur and temperature before the first example
- *Note: When superheat is no longer successful, fsolve won't be able to solve an equation successfully. Thus, the exit status of every stage is shown to determine when superheating and expanding can no longer be performed.
- *Note: We assume that we have pure water only.

FUNCTIONS
endptsolver: Solves for when expansion reaches its endpoint, i.e. the vapor liquid saturation line.
multistgsolver: This is the main solver function that we have.