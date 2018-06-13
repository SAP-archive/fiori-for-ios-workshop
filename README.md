# fiori-for-ios-workshop
Reference iOS application for SAP Fiori for iOS 2018 workshop series.

# Install package ('Delivery Unit')

## Create Database
In SAP Cloud Platform Cockpit, select **SAP HANA / SAP ASE > Database & Schemas**.  Tap to create a new Database.  

![](https://user-images.githubusercontent.com/377404/39138253-660b6538-46d4-11e8-9b41-74dbb286c8ec.png)

Select name for the database, and a SYSTEM user password.  Note that the system user password must be 15 char with lower/upper-cased characters.

![](https://user-images.githubusercontent.com/377404/39138254-663f9416-46d4-11e8-9d20-7443e9d5091a.png)

It will take a few minutes to create the db.  You can monitor the status in the Events window.

![](https://user-images.githubusercontent.com/377404/39138256-66822b46-46d4-11e8-9764-4b1ff5323f79.png)

## Create DB Developer user, and grant permissions
The SYSTEM user should not be used for developing on the database, so you'll need to create a developer user which will have rights to import and publish the package.

From the Overview tab, follow the link **Administration Tools: SAP HANA Cockpit**, and log-in with the SYSTEM user and password you created above.  

![](https://user-images.githubusercontent.com/377404/39138259-66a626ea-46d4-11e8-8d65-8e6304a88d41.png)

You'll be informed that you do not yet have the requisite privileges; click "OK", and they will be granted to you.  

![](https://user-images.githubusercontent.com/377404/39138260-66c68f5c-46d4-11e8-9283-050c12bcc23f.png)

When completed, you can access the SAP HANA Database Administration dashboard.

![](https://user-images.githubusercontent.com/377404/39138261-66fa1c6e-46d4-11e8-95ba-6d943e90397c.png)

Select **Manage Roles and Users**.

Navigate in the explorer to  **Security > Users > SYSTEM**, and right-click on SYSTEM.  Select "Copy User".  

![](https://user-images.githubusercontent.com/377404/39138263-6740b034-46d4-11e8-8654-44843724aa31.png)

A new userID will be proposed, and you need to supply a user password.  When submitted, the Job Log will indicate that they copy is in state "To be reviewed", and you can close the log box.  

![](https://user-images.githubusercontent.com/377404/39138264-67647a1e-46d4-11e8-901c-d3f2b7d1a1af.png)

> Note:  the console may indicate that a number of privilege grants have failed due to insufficent privileges.  For the purpose of this project, you may ignore these warnings.

Select the newly created user ('USER1' by default), switch to the "Granted Roles" tab, and tap the 'plus' button to add privileges.  

![](https://user-images.githubusercontent.com/377404/39138266-67b098f4-46d4-11e8-8948-453e6962738e.png)

Your developer user should have Administration and Developer privileges.  For convenience, we'll add all of both category.

Search for the string "ADMIN", select all results, and click "OK".  

![](https://user-images.githubusercontent.com/377404/39138267-67d975d0-46d4-11e8-9fca-0f76f9ee425e.png)
Then, do the same for the search string "Developer".  'Command+S' to save the changes to your new user.

## Switch to new user, and import Delivery Unit

Make sure you remember your passwords for both SYSTEM and your new developer user.  You'll need to switch between them.  Click the 'power' button in the upper right to log-out as SYSTEM, so that you can log back in as USER1 (or your own userID).

After logging out, enter the userID and password of your Developer user.  You'll immediately be prompted to change the password.

![](https://user-images.githubusercontent.com/377404/39138268-67fb9188-46d4-11e8-932e-cf01ac7606d4.png)

Once successful, you can close this window, and return to the SAP Cloud Platform Cockpit > Database Overview page from above.  Now, navigate to **Administration Tools: SAP HANA Cockpit**.  Scroll down on the dashboard, and select **SAP HANA Application Lifecycle Management > Manage Products and Delivery Units**.

![](https://user-images.githubusercontent.com/377404/39138273-68919304-46d4-11e8-8ef3-9b8416e1533d.png)

Switch to the **Products > Delivery Units** tab, and select "Import".  Locate the Delivery Unit file provided, and import.  When successful, the view will refresh momentarily, and you should see a new Delivery unit named "SAPDEVS_SAPEXPENSE", and it should own a set of Packages with name "saptravelexpense".

![](https://user-images.githubusercontent.com/377404/39151086-158437d2-46f9-11e8-8b8c-9f9e41b014d6.png)

## Switch back to SYSTEM user, and grant privileges to USER1 for imported Delivery Unit

Log out again, and log back in as SYSTEM user.  In the **SAP HANA Database Administration** dashboard, select **Manage Roles and Users**.  In the **SAP HANA Web-based Developent Workbench: Security** tool, navigate **Security > Users > USER1**, and switch to the **Granted Roles** tab.  

![](https://user-images.githubusercontent.com/377404/39138274-68b0debc-46d4-11e8-9d30-fc33f16fb726.png)

Select the 'plus' button, and search for the string "codejam".  

![](https://user-images.githubusercontent.com/377404/39138275-68cffd42-46d4-11e8-8ab4-04aa3c0011e8.png)

Select the available role, and click "OK".  

## Verify connectivity via OData
At this point, your user should be able to access the database via OData.  To verify this, log out of SYSTEM user (for the last time), and back-in as USER1 (or your userID), and try the following URL:

```
https://<database name><hana trial name>.hanatrial.ondemand.com/codejam/saptravelexpense/services/travelexpense.xsodata/expensereport

//e.g.:
https://sapexpensei826181trial.hanatrial.ondemand.com/codejam/saptravelexpense/services/travelexpense.xsodata/expensereport
```

You should see a regular OData response, with one or more expense report entries.

![](https://user-images.githubusercontent.com/377404/39138356-95ea81b2-46d4-11e8-8899-92a4a0e93085.png)

You may also use a REST client, such as Postman, which can provide Basic auth headers.

> If you receive an authorization error (403), make sure you have logged out as SYSTEM, and are logged in as USER1 (or your own Developer userID)

> If you receive privileges error (258), go back to the USER1 role granting for "codejam", and ensure it was properly added.

## Create mobile application with DU Destination

During the Native Mobile App creation procedure, create an `Internet` type destination, pointing to your OData service.  The format should be similar to the URL you tested above, ending at `../travelexpense.xsodata/`.

```
https://<database name><hana trial name>.hanatrial.ondemand.com/codejam/saptravelexpense/services/travelexpense.xsodata/
```

Select `Basic` authentication, and supply the credentials of your Developer user (e.g. USER1).  
