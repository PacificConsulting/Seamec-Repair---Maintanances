tableextension 50103 "Item Jour Line" extends "Item Journal Line"
{
    fields
    {
        field(50050; "Job Card Ref."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}