# Multifactor Authentication at TACC 
*Last update: January 14, 2022*

TACC requires Multi-Factor Authentication (MFA) as an additional security measure when accessing all compute and storage resources.  To set up MFA pairing at TACC on your approved account, proceed directly to the [TACC pairing page](http://portal.tacc.utexas.edu/account-profile/-/mfa/pairing).

## [What is Multi-Factor Authentication?](#whatismfa) { #whatismfa }

Authentication is the process of determining if you are you. Traditional methods of associating a user account with a single password have not been 100% successful. Multi-Factor Authentication (MFA) requires another step, or "factor", in the authenticaton process. In addition to the usual password users must complete authentication using another device unique to them, usually the user's mobile phone/device. 

## [Setting up MFA at TACC](#setupmfa) { #setupmfa }

!!! note
	If you are trying to set up MFA on a new account, you will not be able to generate a QR Code until after your account request is accepted by TACC Staff. Account requests are usually approved within 24 hours.

### [1. Manage Profile](#setupmfa-step1) { #setupmfa-step1 }

To pair a new device, sign in to the TACC User Portal and click on the "Manage Profile" link in the right corner. Users who've not set up MFA before will see a message similar to Figure 1.

<figure id="figure1"><img border="1" alt="" src="../../imgs/tutorials/MFA-1.png" style="width:50%">
<figcaption>Figure 1. Profile with no MFA enabled</figcaption></figure>

Click "Pair a Device" to get to the TACC device pairing page. Here you'll be presented with two different pairing methods. Users may authenticate with one and only one method. It's easy to pair and unpair using either of the first two methods. 

<figure id="figure2"><img alt="" src="../../imgs/tutorials/MFA-2.png" style="width:50%"> 
<figcaption>Figure 2. Select Pairing Method</figcaption></figure>
	
### [2. Select Pairing Method](#setupmfa-step2) { #setupmfa-step2 }

TACC offers two mutually exclusive authentication (pairing) methods.  

* [Multi-Factor Authentication Apps](#mfaapps)

	Users with Apple iOS and Android devices may set up device pairing using a variety of authentication applications, as well as the TACC Token app, available for both <a href="https://itunes.apple.com/us/app/tacc-token/id1081516137?mt=8">Android</a> and <a href="https://itunes.apple.com/us/app/tacc-token/id1081516137?mt=8">iPhone</a> devices.

* [SMS Text Messaging](#sms)

	Users may instead enable multi-factor authentication with SMS, standard text messaging.”

!!! note
	Users located outside the U.S. **must** pair using a [Multi-Factor Authentication app](#mfaapps) of your choice. Because the cost associated with sending multiple international text messages is prohibitive, international users may NOT set up multi-factor authentication with SMS.

####  [MFA Authentication Apps](#mfaapps) { #mfaapps }

Download and install your preferred MFA App on your Apple IOS or Android device, then follow the app instructions to pair your mobile device.  Table 1. features a few of the more popular applications along with links to the respective Apple App and Google Play stores.

[Table 1. MFA Authentication Apps](#table1)

Operating System | MFA Authentication Apps
--- | ---
IOS / Apple devices<br>Apple App Store | <a href="https://apps.apple.com/us/app/duo-mobile/id422663827" target="_blank">Duo</a><sup>&#8663;</sup>&nbsp;&nbsp; <a href="https://apps.apple.com/us/app/1password-password-manager/id568903335" target="_blank">1Password</a><sup>&#8663;</sup>&nbsp;&nbsp; <a href="https://apps.apple.com/us/app/google-authenticator/id388497605" target="_blank">Google Authenticator</a><sup>&#8663;</sup>
Android<br>Google Play | <a href="https://play.google.com/store/apps/details?id=com.duosecurity.duomobile&hl=en_US&gl=US" target="_blank">Duo</a><sup>&#8663;</sup>&nbsp;&nbsp; <a href="https://play.google.com/store/apps/details?id=com.onepassword.android&hl=en_US&gl=US" target="_blank">1Password</a><sup>&#8663;</sup>&nbsp;&nbsp; <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US&gl=US" target="_blank">Google Authenticator</a><sup>&#8663;</sup>


#### [SMS (text) Messaging](#sms) { #sms }

Instead of using an app, users may instead enable multi-factor authentication with SMS, standard text messaging.

When logging into a TACC resource you'll be prompted for your standard password, and then prompted for a "TACC Token Code".  At this point a text message will be sent to your phone with a unique six-digit code.  Enter this code at the prompt.  

**This token code is valid for this login session only and cannot be re-used.  It may take up to 60 seconds for the text to reach you.  We advise you to clear out your text messages in order to avoid confusion during future logins.**

<table border="1"><tr>
<td><figure id="figure3a"><img border="1" alt="" src="../../imgs/tutorials/MFA-3a.png" style="width:50%">
<figcaption>Figure 3a. SMS pairing code</figcaption></figure></td>
<td><figure id="figure3b"><img border="1" alt="" src="../../imgs/tutorials/MFA-3b.png" style="width:50%">
<figcaption>Figure 3b. Pairing with SMS</figcaption></figure></td></tr></table>

## [Example: Pairing with TACC Token App](#tacctokenapp) { #tacctokenapp }

Here we demonstrate pairing with the TACC Token App, though you may use any any MFA app you like.  

Begin by pressing the "Use Your Preferred Authenticator App to Pair" button on the portal (Figure 2. above).  A personalized QR code will be generated on your computer screen as in Figure 4. below. 

<figure id="figure4"><img alt="" src="../../imgs/tutorials/MFA-4.png" style="width:50%"> 
<figcaption> Figure 4. Scan the generated QR code on your screen</figcaption></figure>

3. Open the TACC Token App on your device. Your mobile device screen should appear similar to Figure 5a. Tap the "+" in the lower right corner of the app to start the pairing process.  The app will launch the mobile device's camera.  Scan the generated QR code on your computer screen.  Do not scan the image on this tutorial's page. 

<table border="1"><tr>
<td><figure id="figure5a"><img border="1" src="../../imgs/tutorials/MFA-5a.png" style="width:50%"> 
<figcaption > Figure 5a.</figcaption></figure></td>
<td><figure id="figure5b"><img border="1" alt="" src="../../imgs/tutorials/MFA-5b.png" style="width:50%">
<figcaption> Figure 5b. TACC Token App<br>generating token code</figcaption></figure></td></tr></table>

## [Logging into TACC Resources](#login) { #login }

A typical login session will look something like this:

<pre class="cmd-line">
localhost$ <b>ssh bjones@maverick2.tacc.utexas.edu</b>
To access the system:

1) If not using ssh-keys, please enter your TACC password at the password prompt
2) At the TACC Token prompt, enter your 6-digit code followed by <return>.

<span style="color: blue;">Password: </span></span>
<span style="color: blue;">TACC Token Code:</span></span>
Last login: Mon Nov  1 18:42:37 2021 from 76.167.191.93
------------------------------------------------------------------------------
&nbsp;           		Welcome to the Maverick2 Supercomputer
&nbsp;	Texas Advanced Computing Center, The University of Texas at Austin
------------------------------------------------------------------------------
&nbsp;...

login1.maverick2(399)$ </pre>


After typing in your password, you'll be prompted for "**`TACC Token Code:`**".  At this point, turn to your mobile device/phone.  

* If you've paired with the TACC Token App, open the app and the enter the six-digit number currently being displayed.  If you mis-type the number, just wait till the app cycles (every 30-60 seconds) and try again with the next number (figure 9b).

* If you've paired with SMS, you'll receive a text message containing a six digit verification code (figure 9a).  Enter this code at the **`TACC Token Code:`** prompt.  Please note that it may take up to 60 seconds for the text containing the token code to reach you.  Each token code is valid for one login only and cannot be re-used.  


<table border="1"><tr>
<td><figure id="figure6a"><img alt="" src="../../imgs/tutorials/MFA-6a.png" style="width:50%">
<figcaption> Figure 6a. SMS token code </figcaption></figure></td>
<td><figure id="figure6b"><img border="1" alt="" src="../../imgs/tutorials/MFA-6b.png" style="width:50%">
<figcaption> Figure 6b. TACC Token App token code</figcaption></figure></td></tr></table>

## [International Users and Travelers](#international) { #international }

Users located outside the U.S. **must** pair using a [Multi-Factor Authentication app](#mfaapps) of your choice. Because the cost associated with sending multiple international text messages is prohibitive, international users may NOT set up multi-factor authentication with SMS.  

## [Unpairing your Device](#unpair) { #unpair }

To unpair your device, sign into the TACC User Portal and click on "Manage Profile".  Depending upon the method of pairing you'll see a message similar to Figure 7.  Click on the red subtract symbol to begin the unpairing process.

<figure id="figure7"><img src="../../imgs/tutorials/MFA-7.png" style="width:50%"></p>
<figcaption> Figure 7. Profile configured with SMS pairing</figcaption></figure>

On the next screen (Figure 8.) you'll be asked to to confirm the unpairing.  Similar to the pairing process, you must verify unpairing by entering the token code when prompted.  If you've lost access to the device you originally paired with, you may unpair using email notification.


<figure id="figure8"><img border="1" alt="SMS Unpairing" src="../../imgs/tutorials/MFA-8.png" style="width:50%">
<figcaption> Figure 8. Unpairing TACC Token App or SMS pairings</figcaption></figure>

