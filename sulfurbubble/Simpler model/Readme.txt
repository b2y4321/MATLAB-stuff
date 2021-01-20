- This simple model accounts for velocity of the boundary layer of a gas bubble in scrubbing. "Simple" means that we assume the base concentration (whatever aqueous scrubbing agent we use) is much higher than the concentration of whatever gas shit we are scrubbing. This also implies that concentration of base is about constant.
- simple_solve: The velocity of the boundary depends on c(0) and c(1). We solve for c(1) such that when put in an matrix, rref results in the same c(1).
- simple_eval: after we solve for the c(1) mentioned earlier, we simply rref to find our final concentration values.

___________
Master programs:

singlesolver: Solves for a single time point, the finite difference solution.
simple_MASTER: Solves for finite difference solutions between a time difference t, and thus gives the concentration profile over time assuming a PSSH approach.