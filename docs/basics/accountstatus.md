# Managing your TACC Account
*Last update: Jan 22, 2025*

This document describes the TACC ecosystem that consists not only of HPC resources, but also portals and stuff. ,  how to create and manage your TACC account, the TACC account creation process.  

## TACC Portals and HPC Resources

TACC provides its access to several portals along with access to computing resources.  

<table border="1">
<tr>
<td width=50%>
<h3><a href="">TACC Accounts Portal</a></h3>
Manage your TACC account
<li>User profile
<li>Password management
<li>View account status
<li>Login support tool
</td>


<td>
<h3><a href="">TACC User Portal</a></h3>
<li>Logon requirements: an Active TACC account
<li>Monitor your HPC jobs 
<li>Monitor your allocation usage and SU consumption
<li>PI's may add users to their allocations
</td>
</tr>

<tr>
<td width=50%>
<h3><a href="docs.tacc.utexas.edu">TACC Documentation</a></h3>
TACC-specific technical documentation 
<li>HPC resource user guides 
<li>Software package user guides
<li>TACC tutorials
</td>


<td>
<h3><a href="">HPC Resources</a></h3>
**Currently**: Frontera, Vista, Lonestar6, Stampede3.  
**Logon requirements**: 
<li>An Active TACC Portal account
<li>Belong to a project with an active allocation
<li>Check your allocation status here
</td>
</tr>
</table>

## New Accounts

Any user of TACC resources, HPC resources, Design-Safe, etc. must have a TACC Portal account.  A TACC account email is of the form *username*@tacc.utexas.edu.

!!! important 
	An individual may not have more than one TACC account.  Sharing accounts and/or multi-user accounts are prohibited.  

To create a new account, go to the TACC Accounts Portal and click "Create a New Account" to begin registration..  
Once you"ve agreed to TACC"s Acceptable Use Policy, you"ll be redirected immediately to set up Multi-Factor Authentication on your new account.   

### Identity Management

Any user registering for a new account, reactivating a deactivated account, or updating their profile will be required to authenticate using one of the UT approved Identity Provider services.  All existing accounts will be required to authenticate with one of these identity providers at the yearly profile update. 

* UT EID
* InCommon Federation
* Apple
* Google
* Microsoft

## Diagnosing Login Problems

If you are having issues with your account, TACC's login support tool is the fastest way to diagnose and resolve any problems. You may also use it to simply check the status of your account. Your user profile will also list the current status of your account. 

Provided below is additional information about different account statuses, what they mean, and potential next steps.

### Account Statuses

You may view your account status at any time on the TACC Accounts Portal

* **Pending Email Confirmation**

Once you submit your new account request, your account status immediately updates to this status.   Once you submit your account request, you will receive an email with a link to confirm and activate your account.  Until you click this link, your account status will be listed as `PendingEmailConfirmation`.

If you haven't received the  email, check your spam or junk folder and any filters. Add "`no-reply@tacc.utexas.edu`" to your safe senders list, then request the activation link again.


If your account status turns to Active, you will now need to set up an MFA pairing for your account. You may refer to our MFA instructions page for information on how to set up your MFA. If your account turns into a Pending status after activation, please refer below for the next steps.

* **Pending**

If your account status is Pending then your account request will need to undergo further review by our team. You will receive an email from us with the results of the review.

No action is required from you if your account status is Pending, but please do reach out to our help desk if you have any questions or concerns.
Active
All is well.  Active account holders may log on to any of their allocated TACC resources. Check allocations blah.

* **Deactivated**

If you have not logged into This status occurs as a result of TACC's 120-day inactivity policy. If you have not used your account in 120 consecutive days, your account will automatically get deactivated per our security protocols. You can activate your account by logging into the TACC Accounts site (https://accounts.tacc.utexas.edu/activate) and requesting an activation link.

Important: You will have to reconfigure MFA once your account is reactivated.

* **Suspended**

If your account is suspended you will be prohibited from logging into any HPC resources. Account suspension may result if:
Your HPC jobs are violating Good Conduct Policies or causing harm to our systems
Your account usage is in violation of our usage policies/AUP.
If your account is suspended please submit a help desk ticket and a member of our team contact you shortly/will walk you through what went wrong and what you will need to do in order to unsuspend your account. 


### SSH Keys

This is most likely because you have modified your known hosts file to facilitate a no-password login. Let us try generating a new ssh folder to clear any conflicting keys/logins (you will still have the contents of your current ssh folder under a different name):

1. Go to your home directory using the command:
cd $HOME
2. Change the name of your .ssh folder to old_ssh (so the contents are still accessible in old_ssh, should you need to revisit them at any point) using the command: 
mv .ssh old_ssh
3. Log out of the system and ssh back in, this will auto-generate a new .ssh folder and key for you. 
Once that happens you can try making the change for a password-less login. Please let me know if that works for you or if you have any other questions.

## References

* Submit a support ticket TACC Login Support Tool
* TACC Accounts
* TACC Acceptable Use Policy
* MFA at TACC
