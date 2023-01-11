pageextension 50100 "Fixed Asset Card" extends 5600
{
    layout
    {

    }

    actions
    {
        addafter("Ma&in Asset Statistics")
        {
            Action("Component List")
            {
                RunObject = Page "Job Component List";
                RunPageLink = "FA No." = FIELD("No.");
            }

            Action("Job List")
            {
                RunObject = Page "Job Maintenance List";
                RunPageLink = "FA No." = FIELD("No.");
            }
        }
    }


    var
        myInt: Integer;
}