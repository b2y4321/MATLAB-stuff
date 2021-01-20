What this program does is that it uses the Bar-Cohen correlation for heat fins to determine the heat flow from the fin assembly. It finds the heat flow from a single channel in the heatsink, which of course can be multiplied by the number of channels to find total heat flow.

Given that the convection coefficient depends on Ra, which obviously depends on the air thermophysical properties at mean temperature of the heatsink - we need to match (1) the heat flow predicted by the Bar-Cohen correlation at some given set of properties and (2) the heat absorbed by the air, dependent on the heat capacity (assumed constant) and inlet/outlet temperatures. 

Since the fluid temperature (by proxy dependent on the outlet temperature, which is unknown) determines the properties that will influence heat transfer in the Bar-Cohen relation, we must take into account and find a temperature where these heat flows are equal.

TempSolver1: Is the script called by fsolve to find temperature that matches these heatflows.

TempSummary: Calls the TempSolver1 script and summarizes useful data findings (heat flow, etc) based on the iteratively-solved out temperature.

TempIter: Don't use