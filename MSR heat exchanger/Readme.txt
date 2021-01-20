- So the combined heat exchange system features liquid salt exchange with water, considering water heating both in subcritical and supercritical regimes. Supercritical properties are from NIST. This heat exchanger is paralell plate, counterflow.
- subcritical and supercritical heat exchanger part solve for only one heat transfer regime or another.

- Heat generation calcs: Given a desired outlet temperature and other properties related to the molten salt, run fsolve on freeflowsolver in order to find the mass flow rate for this to occur. freeflow only solves the outlet temperature for a given flow rate specified of molten salt.

- rodflow algorithm was never completed