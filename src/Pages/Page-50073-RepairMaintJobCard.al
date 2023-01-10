page 50073 "Repair & Maint. Job Card"
{
    PageType = Card;
    SourceTable = 50032;


    layout
    {
        area(content)
        {
            group("Intimation Of Issue")
            {
                field("No."; rec."No.")
                {

                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("FA No."; rec."FA No.")
                {
                    ApplicationArea = all;
                }
                field("FA Description"; rec."FA Description")
                {
                    ApplicationArea = all;
                }
                field("Is it a Production Loss"; rec."Is it a Production Loss")
                {
                    ApplicationArea = all;
                }
                field("Description of the Problem"; rec."Description of the Problem")
                {
                    ApplicationArea = all;
                }
                field("Creation Date-Time"; rec."Creation Date-Time")
                {
                    ApplicationArea = all;
                }
                field("Break-Down Since"; rec."Break-Down Since")
                {
                    ApplicationArea = all;
                }
                field("Maintenance Type"; rec."Maintenance Type")
                {
                    ApplicationArea = all;
                }
                field("Created By"; rec."Created By")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 1 Code"; rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Shortcut Dimension 2 Code"; rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Final Comments"; rec."Final Comments")
                {
                    ApplicationArea = all;
                }
            }
            group("Identification & Resolution")
            {
                field(Component; rec.Component)
                {
                    ApplicationArea = all;
                }
                field("Component Description"; rec."Component Description")
                {
                    ApplicationArea = all;
                }
                field("Sub-Component 1"; rec."Sub-Component 1")
                {
                    ApplicationArea = all;
                }
                field("Sub-Component 1 Description"; rec."Sub-Component 1 Description")
                {
                    ApplicationArea = all;
                }
                field("Sub-Component 2"; rec."Sub-Component 2")
                {
                    ApplicationArea = all;
                }
                field("Sub-Component 2 Description"; rec."Sub-Component 2 Description")
                {
                    ApplicationArea = all;
                }
                field("Category Of Problem"; rec."Category Of Problem")
                {
                    ApplicationArea = all;
                }
                field("Resource Provider"; rec."Resource Provider")
                {
                    ApplicationArea = all;
                }
                field("Nature of Problem"; rec."Nature of Problem")
                {
                    ApplicationArea = all;
                }
                field("Maintenance Activity Start"; rec."Maintenance Activity Start")
                {
                    ApplicationArea = all;
                }
                field("Maintenance Activity Finish"; rec."Maintenance Activity Finish")
                {
                    ApplicationArea = all;
                }
                field("What Was Done"; rec."What Was Done")
                {
                    ApplicationArea = all;
                }
                field("Root Cause"; rec."Root Cause")
                {
                    ApplicationArea = all;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Fault Found or Not"; rec."Fault Found or Not")
                {
                    ApplicationArea = all;
                }
                field("Consumable Stockout"; rec."Consumable Stockout")
                {
                    ApplicationArea = all;
                }
                field("Hours Consumed In Stockout"; rec."Hours Consumed In Stockout")
                {
                    ApplicationArea = all;
                }
            }
            group("Closure Of Issue")
            {
                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                }
                field("Production Restart"; rec."Production Restart")
                {
                    ApplicationArea = all;
                }
                field("Est. Production Loss (MT)"; rec."Est. Production Loss (MT)")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Work Order No."; rec."Work Order No.")
                {
                    Enabled = false;
                    Visible = false;
                }
                field("Vendor Name"; rec."Vendor Name")
                {
                    Visible = false;
                }
                field("Creation Date"; rec."Creation Date")
                {
                    Visible = false;
                }
                field("Start Date"; rec."Start Date")
                {
                    Visible = false;
                }
                field("End Date"; rec."End Date")
                {
                    Visible = false;
                }
            }
            part(MaintenanceSubPage; 50074)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
            part(MaintenanceSubPage1; 50076)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
            part("Maintenance Resource SubPage"; 50083)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Update Line")
            {
                Visible = false;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    rec.TESTFIELD("Location Code");
                    IF recFA.GET(rec."FA No.") THEN BEGIN
                        rec."FA Description" := recFA.Description;
                        MaintenanceLine.RESET;
                        MaintenanceLine.SETRANGE("Document No.", rec."No.");
                        IF MaintenanceLine.FINDFIRST THEN
                            MaintenanceLine.DELETEALL;
                        CLEAR(vLine);
                        ComponentList.RESET;
                        ComponentList.SETRANGE("FA No.", rec."FA No.");
                        IF ComponentList.FINDFIRST THEN BEGIN
                            REPEAT
                                IF vLine = 0 THEN
                                    vLine := 10000;
                                recML.INIT;
                                recML."Document No." := rec."No.";
                                recML."Line No." := vLine;
                                recML."Component Type" := ComponentList."Component Type";
                                recML."Consumable Component" := ComponentList.Component;
                                recML.Quantity := ComponentList.Quantity;
                                recML.Description := ComponentList.Description;
                                recML."Location Code" := rec."Location Code";
                                recILE.RESET;
                                recILE.SETRANGE("Location Code", rec."Location Code");
                                recILE.SETRANGE("Item No.", ComponentList.Component);
                                IF recILE.FINDFIRST THEN
                                    REPEAT
                                        recML."Inventory  Qty" += recILE."Remaining Quantity";
                                    UNTIL recILE.NEXT = 0;
                                recML.INSERT;
                                vLine += 10000;
                                COMMIT;
                            UNTIL ComponentList.NEXT = 0;
                        END;
                    END;
                end;
            }
            action("Close Job Card")
            {
                Image = Close;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    //PCPL-PM/0017
                    rec.TESTFIELD(rec."FA No.");
                    rec.TESTFIELD("Is it a Production Loss");
                    rec.TESTFIELD(Component);
                    rec.TESTFIELD("Description of the Problem");
                    rec.TESTFIELD("Nature of Problem");
                    rec.TESTFIELD("What Was Done");
                    rec.TESTFIELD("Fault Found or Not");
                    IF rec."Is it a Production Loss" = rec."Is it a Production Loss"::Yes THEN
                        rec.TESTFIELD("Est. Production Loss (MT)");
                    IF USERID <> rec."Created By" THEN
                        ERROR('Job card can be closed by only the person who created it');

                    //post-validation
                    CLEAR(vUQty);
                    MaintenanceLine.RESET;
                    MaintenanceLine.SETRANGE("Document No.", rec."No.");
                    IF MaintenanceLine.FINDFIRST THEN
                        IF MaintenanceLine."Component Type" = MaintenanceLine."Component Type"::Item THEN BEGIN
                            MaintenanceLine.CALCFIELDS(MaintenanceLine."Quantity Utilized");
                            vUQty := MaintenanceLine."Quantity Utilized";
                            IF MaintenanceLine.Quantity <> vUQty THEN
                                REPEAT
                                    ERROR('Quantity must be equal to utilized quantity. Please check whether consumption is posted or not!');
                                UNTIL MaintenanceLine.NEXT = 0;
                        END;
                    //PCPL-PM/0017
                    IF rec.Status = rec.Status::"Under Maintenance" THEN BEGIN
                        rec.Status := rec.Status::Close;
                        rec.MODIFY;
                    END;

                    IF rec.Status = rec.Status::Close THEN BEGIN
                        CurrPage.EDITABLE(FALSE);
                        CurrPage.MaintenanceSubPage.PAGE.EDITABLE(FALSE);
                    END;
                end;
            }
            action(Post)
            {
                Enabled = false;
                Image = Post;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    //TESTFIELD(Status,Status::"Under Maintenance"); //PCPL0017 Not Needed
                    MaintenanceLine.RESET;
                    MaintenanceLine.SETRANGE("Document No.", rec."No.");
                    MaintenanceLine.SETRANGE("Component Type", MaintenanceLine."Component Type"::Item);
                    IF MaintenanceLine.FINDFIRST THEN
                        REPEAT
                            //IF MaintenanceLine."Inventory  Qty"<=0 THEN //Previous
                            IF MaintenanceLine."Inventory  Qty" > MaintenanceLine.Quantity THEN //PCPL0017 New
                                ERROR('Inventory  Quantity is 0 for Item %1', MaintenanceLine."Consumable Component");
                        UNTIL MaintenanceLine.NEXT = 0;

                    CLEAR(vLine);
                    MaintenanceLine.RESET;
                    MaintenanceLine.SETRANGE("Document No.", rec."No.");
                    MaintenanceLine.SETRANGE("Component Type", MaintenanceLine."Component Type"::Item);
                    IF MaintenanceLine.FINDFIRST THEN
                        REPEAT
                            IF vLine = 0 THEN
                                vLine := 10000;
                            ItemJournalLine.RESET;
                            ItemJournalLine.INIT;
                            ItemJournalLine."Journal Batch Name" := 'PREV MAINT';
                            ItemJournalLine."Journal Template Name" := 'ITEM';
                            ItemJnlTemplate.GET('ITEM');
                            ItemJnlBatch.GET('ITEM', 'PREV MAINT');
                            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                            ItemJournalLine."Document Date" := WORKDATE;
                            IF ItemJnlBatch."No. Series" <> '' THEN BEGIN
                                CLEAR(NoSeriesMgt);
                                ItemJournalLine."Document No." := NoSeriesMgt.GetNextNo(ItemJnlBatch."No. Series", TODAY, FALSE);
                            END;
                            ItemJournalLine."Line No." := vLine;
                            ItemJournalLine."Posting Date" := TODAY;
                            ItemJournalLine."Item No." := MaintenanceLine."Consumable Component";
                            ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, MaintenanceLine.Quantity);
                            ItemJournalLine."Location Code" := MaintenanceLine."Location Code";
                            ItemJournalLine."Bin Code" := MaintenanceLine."Bin Code";
                            recItem.GET(MaintenanceLine."Consumable Component");
                            ItemJournalLine.Description := recItem.Description;
                            ItemJournalLine."Unit of Measure Code" := recItem."Base Unit of Measure";
                            ItemJournalLine."Gen. Prod. Posting Group" := recItem."Gen. Prod. Posting Group";
                            ItemJournalLine."Job Card Ref." := rec."No.";
                            ItemJournalLine.INSERT;
                            vLine += 10000;
                        UNTIL MaintenanceLine.NEXT = 0;
                    //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",ItemJournalLine);
                    MESSAGE('Item Journal Line has been created');
                end;
            }
            action("Create Work Order")
            {
                Image = "Action";
                Visible = false;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    /*
                    TESTFIELD("Vendor No.");
                    TESTFIELD("Work Order No.",'');
                    TESTFIELD("Location Code"); //PCPL0017
                    MaintenanceLine.RESET;
                    MaintenanceLine.SETRANGE("Document No.","No.");
                    MaintenanceLine.SETRANGE("Component Type",MaintenanceLine."Component Type"::"G/L Account");
                    IF NOT MaintenanceLine.FINDFIRST THEN
                      ERROR('GL lines are not available in this Job Card')
                    ELSE BEGIN
                      PurchaseHeader.INIT;
                      PurchSetup.GET;
                      //PurchaseHeader."No.":=NoSeriesMgt.GetNextNo(PurchSetup."Order Nos.",TODAY,FALSE);
                      NoSeriesMgt.InitSeries(PurchSetup."Work Order No.",PurchSetup."Work Order No.",TODAY,PurchaseHeader."No.",PurchSetup."Work Order No.");
                      PurchaseHeader.VALIDATE("Work Order",TRUE);
                      PurchaseHeader.VALIDATE("Posting Date",TODAY);
                      PurchaseHeader.VALIDATE("Document Type",PurchaseHeader."Document Type"::Order);
                      PurchaseHeader.VALIDATE("Buy-from Vendor No.","Vendor No.");
                      PurchaseHeader.VALIDATE("Location Code","Location Code");
                      PurchaseHeader.INSERT;
                      CLEAR(vLine);
                      MaintenanceLine.RESET;
                      MaintenanceLine.SETRANGE("Document No.","No.");
                      MaintenanceLine.SETRANGE("Component Type",MaintenanceLine."Component Type"::"G/L Account");
                      IF MaintenanceLine.FINDFIRST THEN REPEAT
                        PurchaseLine.RESET;
                        PurchaseLine.SETRANGE("Document Type",PurchaseHeader."Document Type");
                        PurchaseLine.SETRANGE("Document No.",PurchaseHeader."No.");
                        IF PurchaseLine.FINDLAST THEN
                          vLine:=PurchaseLine."Line No."+10000
                        ELSE
                          vLine:=10000;
                        PurchaseLine.INIT;
                        PurchaseLine."Document No.":=PurchaseHeader."No.";
                        PurchaseLine.VALIDATE("Document Type",PurchaseHeader."Document Type");
                        PurchaseLine."Line No.":=vLine;
                        PurchaseLine.VALIDATE(Type,PurchaseLine.Type::"G/L Account");
                        PurchaseLine.VALIDATE("No.",MaintenanceLine."Consumable Component");
                        PurchaseLine.VALIDATE(Quantity,MaintenanceLine.Quantity);
                        PurchaseLine.INSERT;
                        vLine+=10000;
                      UNTIL MaintenanceLine.NEXT=0;
                      "Work Order No.":=PurchaseHeader."No.";
                    END;
                    MESSAGE('Work Order is Created');
                    */

                end;
            }
            //PCPL/NSW/07  Table Missing
            // action("Create Requsition")
            // {
            //     Image = "Action";

            //     trigger OnAction()
            //     begin
            //         rec.TESTFIELD("Location Code");//PCPL0017
            //         MaintenanceLine.RESET;
            //         MaintenanceLine.SETRANGE(MaintenanceLine."Document No.", rec."No.");
            //         MaintenanceLine.SETRANGE(MaintenanceLine."Component Type", MaintenanceLine."Component Type"::Item);
            //         IF MaintenanceLine.FINDFIRST THEN
            //             REPEAT
            //                 MaintenanceLine.CALCFIELDS(MaintenanceLine."Inventory  Qty");
            //                 IF MaintenanceLine.Quantity <= MaintenanceLine."Inventory  Qty" THEN
            //                     ERROR('Inventory is already available. Please create Requisition only if it is needed');//PCPL0017
            //             UNTIL MaintenanceLine.NEXT = 0;
            //         CLEAR(ReqCreated);
            //         MaintenanceLine.RESET;
            //         MaintenanceLine.SETRANGE(MaintenanceLine."Document No.", rec."No.");
            //         MaintenanceLine.SETRANGE(MaintenanceLine."Component Type", MaintenanceLine."Component Type"::Item);
            //         MaintenanceLine.SETRANGE(MaintenanceLine."Req no.", '');
            //         IF NOT MaintenanceLine.FINDFIRST THEN
            //             ERROR('No Item lines in Job Card or Requisition already created')
            //         ELSE BEGIN
            //             RequisitionHeader.INIT;
            //             PurchSetup.GET;
            //             //RequisitionHeader."Requisition No":=NoSeriesMgt.GetNextNo(PurchSetup."Requisition No Series",TODAY,FALSE);
            //             NoSeriesMgt.InitSeries(PurchSetup."Requisition No Series", PurchSetup."Requisition No Series", TODAY, RequisitionHeader."Requisition No", PurchSetup."Requisition No Series");
            //             RequisitionHeader.VALIDATE(RequisitionHeader."Required Date", TODAY);//PCPL0017
            //             RequisitionHeader.VALIDATE(RequisitionHeader."Posting Date", TODAY);
            //             RequisitionHeader.VALIDATE(RequisitionHeader.Status, RequisitionHeader.Status::Open);
            //             RequisitionHeader.VALIDATE(RequisitionHeader."Job Reference", rec."No.");//PCPL0017
            //             RequisitionHeader.VALIDATE(RequisitionHeader."Location Code", rec."Location Code");//PCPL0017
            //             RequisitionHeader.VALIDATE(RequisitionHeader."Final Version", TRUE);
            //             COMMIT;
            //             RequisitionHeader.INSERT;
            //             COMMIT;
            //             ReqCreated := TRUE;
            //             CLEAR(vLine);
            //             MaintenanceLine.RESET;
            //             MaintenanceLine.SETRANGE(MaintenanceLine."Document No.", rec."No.");
            //             MaintenanceLine.SETRANGE(MaintenanceLine."Component Type", MaintenanceLine."Component Type"::Item);
            //             MaintenanceLine.SETFILTER(MaintenanceLine."Req no.", '');
            //             IF MaintenanceLine.FINDFIRST THEN
            //                 REPEAT
            //                     IF ReqCreated THEN BEGIN
            //                         RequisitionLine.RESET;
            //                         RequisitionLine.SETRANGE(RequisitionLine."Requisition No", RequisitionHeader."Requisition No");
            //                         IF RequisitionLine.FINDLAST THEN
            //                             vLine := RequisitionLine."Line No" + 10000
            //                         ELSE
            //                             vLine := 10000;
            //                         RequisitionLine.INIT;
            //                         RequisitionLine."Requisition No" := RequisitionHeader."Requisition No";
            //                         RequisitionLine."Line No" := vLine;
            //                         RequisitionLine.VALIDATE(RequisitionLine.Type, RequisitionLine.Type::Item);
            //                         RequisitionLine.VALIDATE(RequisitionLine."No.", MaintenanceLine."Consumable Component");
            //                         RequisitionLine.VALIDATE(RequisitionLine.Quantity, MaintenanceLine.Quantity);
            //                         RequisitionLine.VALIDATE(RequisitionLine."Job Reference No.", rec."No.");
            //                         RequisitionLine.VALIDATE(RequisitionLine."Location Code", rec."Location Code");//PCPL0017
            //                                                                                                        //RequisitionLine.VALIDATE("Bin Code","Bin Code");//PCPL0017
            //                         RequisitionLine.INSERT;
            //                         //vLine+=10000;
            //                         MaintenanceLine."Req no." := RequisitionLine."Requisition No";
            //                         MaintenanceLine."Req Line no." := RequisitionLine."Line No";
            //                         MaintenanceLine.MODIFY;
            //                     END;
            //                 UNTIL MaintenanceLine.NEXT = 0;
            //         END;
            //         MESSAGE('Requisition is Created'); //PCPL0017
            //     end;
            // }
            action("Get Components")
            {
                Image = GetEntries;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    ComponentList.RESET;
                    ComponentList.SETRANGE(ComponentList."FA No.", rec."FA No.");
                    IF ComponentList.FINDSET THEN
                        IF (PAGE.RUNMODAL(50057, ComponentList) = ACTION::LookupOK) THEN;

                    CLEAR(vLine);
                    ComponentList.RESET;
                    ComponentList.SETRANGE(ComponentList."FA No.", rec."FA No.");
                    ComponentList.SETRANGE(ComponentList.Select, TRUE);
                    IF ComponentList.FINDFIRST THEN
                        REPEAT
                            recML.RESET;
                            recML.SETRANGE(recML."Document No.", rec."No.");
                            IF recML.FINDLAST THEN
                                vLine := recML."Line No." + 10000
                            ELSE
                                vLine := 10000;
                            recML.INIT;
                            recML."Document No." := rec."No.";
                            recML."Line No." := vLine;
                            recML."Component Type" := ComponentList."Component Type";
                            recML."Consumable Component" := ComponentList.Component;
                            recML.Description := ComponentList.Description;
                            recML.Quantity := ComponentList.Quantity;
                            recML."Location Code" := rec."Location Code";
                            recILE.RESET;
                            recILE.SETRANGE(recILE."Location Code", rec."Location Code");
                            recILE.SETRANGE(recILE."Item No.", ComponentList.Component);
                            IF recILE.FINDFIRST THEN
                                REPEAT
                                    recML."Inventory  Qty" += recILE."Remaining Quantity";
                                UNTIL recILE.NEXT = 0;
                            recML.INSERT;
                            ComponentList.Select := FALSE;
                            ComponentList.MODIFY;
                        UNTIL ComponentList.NEXT = 0;
                end;
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                // action(IncomingDocCard)
                // {
                //     Caption = 'View Incoming Document';
                //     Enabled = HasIncomingDocument;
                //     Image = ViewOrder;
                //     //The property 'ToolTip' cannot be empty.
                //     //ToolTip = '';

                //     trigger OnAction()
                //     var
                //         IncomingDocument: Record 130;
                //     begin
                //         //IncomingDocument.ShowCardFromEntryNo("Incoming Document Entry No.");
                //     end;
                // }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData 130 = R;
                    Caption = 'Select Incoming Document';
                    Image = SelectLineToApply;
                    ApplicationArea = all;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    trigger OnAction()
                    var
                        IncomingDocument: Record 130;
                    begin
                        rec.VALIDATE("Incoming Document Entry No.", IncomingDocument.SelectIncomingDocument(rec."Incoming Document Entry No.", rec.RecordID));
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Image = Attach;
                    ApplicationArea = all;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record 133;
                    begin
                        //IncomingDocumentAttachment.NewAttachmentFromMHDocument(Rec);
                    end;
                }
                action(RemoveIncomingDoc)
                {
                    Caption = 'Remove Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = RemoveLine;
                    ApplicationArea = all;
                    //The property 'ToolTip' cannot be empty.
                    //ToolTip = '';
                    Visible = false;

                    trigger OnAction()
                    begin
                        rec."Incoming Document Entry No." := 0;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        HasIncomingDocument := rec."Incoming Document Entry No." <> 0;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        rec.TESTFIELD(Status, rec.Status::"Under Maintenance");
    end;

    trigger OnModifyRecord(): Boolean
    begin
        rec.TESTFIELD(Status, rec.Status::"Under Maintenance");
    end;

    trigger OnOpenPage()
    begin
        IF rec.Status = rec.Status::Close THEN
            CurrPage.EDITABLE(FALSE)
        ELSE
            IF rec.Status = rec.Status::"Under Maintenance" THEN
                CurrPage.EDITABLE(TRUE);
    end;

    var
        ItemJournalLine: Record 83;
        MaintenanceLine: Record 50033;
        vLine: Integer;
        recFA: Record 5600;
        vDocNo: Code[20];
        ComponentList: Record 50031;
        recML: Record 50033;
        recILE: Record 32;
        recItem: Record 27;
        ItemJnlTemplate: Record 82;
        ItemJnlBatch: Record 233;
        NoSeriesMgt: Codeunit 396;
        PurchaseHeader: Record 38;
        PurchaseLine: Record 39;
        PurchSetup: Record 312;
        HasIncomingDocument: Boolean;
        //RequisitionHeader: Record 50008; //PCPL/NSW/07
        //RequisitionLine: Record 50009; //PCPL/NSW/07
        ReqCreated: Boolean;
        vUQty: Decimal;
}

