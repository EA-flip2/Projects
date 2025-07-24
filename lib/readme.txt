group object
-title
-description
-contacts
-active contacts

draft
-draftID
-groupID
-newContacts

messenger object
-message
-active contacts
...................
-add rule to send different types of messages

contact modify object
-contacts
-returns contacts

contacts object
- string of contacts
- must be 10





tools
-sms telephony
-send with internet / credit
.........................
-import contacts from an image
-from an xlxs or csv file
-get other data for rules and send to wf
-shows estimate amount of credit/ data needed


draft
{group id, contactList } // saved locally



hive structure
-message object  //holds messages until cleared or deleted
    -message = actual text to send
    -groupID
    -draftID

-group
    -name
    -description
    -contacts
    -drafts

draft
    -name
    -description
    -contacts

setting


draf key = 'draftID=groupID'
group key = 'groupID'