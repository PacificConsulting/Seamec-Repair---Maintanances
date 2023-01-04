tableextension 50104 "Purch.Payable setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50050; "Work Order No."; code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}