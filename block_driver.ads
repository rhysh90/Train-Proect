with Raildefs, Unsigned_Types, dio192defs;

Package block_driver is

   procedure Set_Cab (B : in Raildefs.Block_Id; Cab : in Raildefs.Cab_Type);

   procedure Set_Polarity (B   : in Raildefs.Block_Id; Pol : in Raildefs.Polarity_Type);

   procedure Set_Cab_And_Polarity ( B : in Raildefs.Block_Id; Cab : in Raildefs.Cab_Type;
                                   Pol : in Raildefs.Polarity_Type);

end block_driver;
