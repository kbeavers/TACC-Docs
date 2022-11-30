// Susan Lindsey  
// https://portal.tacc.utexas.edu/tutorials/multifactor-authentication  
<style type="text/css">.help{box-sizing:border-box}.help *,.help *:before,.help *:after{box-sizing:inherit}.row{margin-bottom:10px;margin-left:-15px;margin-right:-15px}.row:before,.row:after{content:" ";display:table}.row:after{clear:both}[class*="col-"]{box-sizing:border-box;float:left;position:relative;min-height:1px;padding-left:15px;padding-right:15px}.col-1-5{width:20%}.col-2-5{width:40%}.col-3-5{width:60%}.col-4-5{width:80%}.col-1-4{width:25%}.col-1-3{width:33.3%}.col-1-2,.col-2-4{width:50%}.col-2-3{width:66.7%}.col-3-4{width:75%}.col-1-1{width:100%}article.help{font-size:1.25em;line-height:1.2em}.text-center{text-align:center}figure{display:block;margin-bottom:20px;line-height:1.42857143;border:1px solid #ddd;border-radius:4px;padding:4px;text-align:center}figcaption{font-weight:bold}.lead{font-size:1.7em;line-height:1.4;font-weight:300}.embed-responsive{position:relative;display:block;height:0;padding:0;overflow:hidden}.embed-responsive-16by9{padding-bottom:56.25%}.embed-responsive .embed-responsive-item,.embed-responsive embed,.embed-responsive iframe,.embed-responsive object,.embed-responsive video{position:absolute;top:0;bottom:0;left:0;width:100%;height:100%;border:0}</style>
<span style="font-size:225%; font-weight:bold;">Multifactor Authentication at TACC </span><br>
<span style="font-size:90%"><i>Last update: January 14, 2022</i></span></p>

:markdown
	TACC requires Multi-Factor Authentication (MFA) as an additional security measure when accessing all compute and storage resources.  To set up MFA pairing at TACC on your approved account, proceed directly to the [TACC pairing page](/account-profile/-/mfa/pairing).



#whatismfa
	:markdown
		# [What is Multi-Factor Authentication?](#whatismfa)

		Authentication is the process of determining if you are you. Traditional methods of associating a user account with a single password have not been 100% successful. Multi-Factor Authentication (MFA) requires another step, or "factor", in the authenticaton process. In addition to the usual password users must complete authentication using another device unique to them, usually the user's mobile phone/device. 

#setupmfa
	:markdown
		# [Setting up MFA at TACC](#setupmfa)

		<p class="portlet-msg-alert">If you are trying to set up MFA on a new account, you will not be able to generate a QR Code until after your account request is accepted by TACC Staff. Account requests are usually approved within 24 hours.</p>

#setupmfa-step1
	:markdown
		## [1. Manage Profile](#setupmfa-step1)

	To pair a new device, sign in to the TACC User Portal and click on the "Manage Profile" link in the right corner. Users who've not set up MFA before will see a message similar to Figure 1.

	%figure
		<img border="1" alt="" src="/documents/10157/1183617/MFA+-+no+pairings+detected/0965b0ff-4137-494c-8b3b-87038daa8891?t=1463672441360" style="width: 200px; height: 163px; border-width: 1px; border-style: solid;" />
		%figcaption
			Figure 1.
			%br Profile with no MFA enabled

	%p Click "Pair a Device" to get to the TACC device pairing page. Here you'll be presented with two different pairing methods. Users may authenticate with one and only one method. It's easy to pair and unpair using either of the first two methods. 

	%figure
		<img alt="" src="/documents/10157/1183617/Pair-A-Device.png/fb6d0545-e83f-4b19-8e99-317b4e5f0f54?t=1636915793332" style="width: 600px; height: 376px; border-width: 1px; border-style: solid;" /> 
		%figcaption
			Figure 2.
			%br Select Pairing Method
	
#setupmfa-step2
	:markdown
		## [2. Select Pairing Method](#setupmfa-step2)
	
		TACC offers two mutually exclusive authentication (pairing) methods.  

		* [Multi-Factor Authentication Apps](#mfaapps)

			Users with Apple iOS and Android devices may set up device pairing using a variety of authentication applications, as well as the TACC Token app, available for both <a href="https://itunes.apple.com/us/app/tacc-token/id1081516137?mt=8">Android</a> and <a href="https://itunes.apple.com/us/app/tacc-token/id1081516137?mt=8">iPhone</a> devices.

		* [SMS Text Messaging](#sms)

			Users may instead enable multi-factor authentication with SMS, standard text messaging.”

		<p class="portlet-msg-alert">Users located outside the U.S. **must** pair using a [Multi-Factor Authentication app](#mfaapps) of your choice. Because the cost associated with sending multiple international text messages is prohibitive, international users may NOT set up multi-factor authentication with SMS.</p>

#mfaapps
	:markdown
		###  [MFA Authentication Apps](#mfaapps)

		Download and install your preferred MFA App on your Apple IOS or Android device, then follow the app instructions to pair your mobile device.  Table 1. features a few of the more popular applications along with links to the respective Apple App and Google Play stores.

#table1
	:markdown
		[Table 1. MFA Authentication Apps](#table1)

	%table(border="1" cellpadding="5" cellspacing="5")
		%tr
			%th Operating System
			%th(align="center") MFA Authentication Apps
		%tr 
			%th IOS / Apple devices<br><font size="smaller">Apple App Store</font>
			%td(align="center") <a href="https://apps.apple.com/us/app/duo-mobile/id422663827" target="_blank">Duo</a><sup>&#8663;</sup>&nbsp;&nbsp; <a href="https://apps.apple.com/us/app/1password-password-manager/id568903335" target="_blank">1Password</a><sup>&#8663;</sup>&nbsp;&nbsp; <a href="https://apps.apple.com/us/app/google-authenticator/id388497605" target="_blank">Google Authenticator</a><sup>&#8663;</sup>
		%tr 
			%th Android<br><font size="smaller">Google Play</font>
			%td(align="center") <a href="https://play.google.com/store/apps/details?id=com.duosecurity.duomobile&hl=en_US&gl=US" target="_blank">Duo</a><sup>&#8663;</sup>&nbsp;&nbsp; <a href="https://play.google.com/store/apps/details?id=com.agilebits.onepassword&hl=en_US&gl=US" target="_blank">1Password</a><sup>&#8663;</sup>&nbsp;&nbsp; <a href="https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=en_US&gl=US" target="_blank">Google Authenticator</a><sup>&#8663;</sup>


#sms
	:markdown
		### [SMS (text) Messaging](#sms)

		Instead of using an app, users may instead enable multi-factor authentication with SMS, standard text messaging.


		When logging into a TACC resource you'll be prompted for your standard password, and then prompted for a "TACC Token Code".  At this point a text message will be sent to your phone with a unique six-digit code.  Enter this code at the prompt.  

		**This token code is valid for this login session only and cannot be re-used.  It may take up to 60 seconds for the text to reach you.  We advise you to clear out your text messages in order to avoid confusion during future logins.**

	.row
		.col-1-6
			&nbsp;
		.col-2-6
			%figure
				<img border="1" alt="" src="/documents/10157/1183617/sms-iphone-code.png/eda6c2e3-0785-4991-b4ef-d7e6ecc2073a?t=1463760841537"style="width: 150px; height: 65px;">
				%figcaption
					Figure 3a.
					%br SMS pairing code
		.col-3-6
			%figure
				<img border="1" alt="" src="/documents/10157/1183617/SMS-pairing-OTP-code.png/b519144e-a4f0-4183-8ffc-81fad1c64ff5?t=1463760840199" style="width: 500px; height: 219px;" />
				%figcaption
					Figure 3b.
					%br Pairing with SMS

#tacctokenapp
#methods-tacctokenapp
	:markdown
		# [Example: Pairing with TACC Token App](#tacctokenapp)

		Here we demonstrate pairing with the TACC Token App, though you may use any any MFA app you like.  

		Begin by pressing the "Use Your Preferred Authenticator App to Pair" button on the portal (Figure 2. above).  A personalized QR code will be generated on your computer screen as in Figure 4. below. 

	%figure
		<img alt="" src="/documents/10157/1183617/TACC+Token+pairing+with+tutorial+QR/d07e994b-0a9a-47f6-97b5-607f40b2a58a?t=1642182110478" style="width: 500px; height: 412px; border-width: 1px; border-style: solid;" /> 
		%figcaption
			Figure 4.
			%br Scan the generated QR code on your screen

	%p 3. Open the TACC Token App on your device. Your mobile device screen should appear similar to Figure 5a. Tap the "+" in the lower right corner of the app to start the pairing process.  The app will launch the mobile device's camera.  Scan the generated QR code on your computer screen.  Do not scan the image on this tutorial's page. 
	.row
		.col-1-2
			%figure
				<img border="1" src="/documents/10157/1183617/TACC+Token+app+-+screen+1/4a026721-5f2c-4047-ab39-72e1a0fd97c0?t=1481565716647" style="width: 160px; height: 284px;" /> 
				%figcaption 
					Figure 5a.

		.col-1-2
			%figure
				<img border="1" alt="" src="/documents/10157/1183617/TACC+Taken+-+number+generation/724544eb-d3fc-48a9-9ff1-3f2565c0c46e?t=1481565778557" style="width: 160px; height: 284px;" />
				%figcaption
					Figure 5b.
					%br TACC Token App<br>generating token code

#login
	:markdown
		# [Logging into TACC Resources](#login)

		A typical login session will look something like this:

		<pre class="cmd-line">localhost$ <b>ssh bjones@maverick2.tacc.utexas.edu</b>
		To access the system:

		1) If not using ssh-keys, please enter your TACC password at the password prompt
		2) At the TACC Token prompt, enter your 6-digit code followed by <return>.

		STYLEBLUEPassword: ESPAN
		STYLEBLUETACC Token Code:ESPAN
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


	.row
		.col-1-2
			%figure
				<img alt="" src="/documents/10157/1183617/MFA+iphone+SMS+2-factor+code/32884319-d143-4561-b985-8997c70fdec2?t=1471376634000" style="border-width: 1px; border-style: solid; height: 284px; width: 160px;" />
				%figcaption
					Figure 6a.
					%br SMS token code 
		.col-1-2
			%figure
				<img border="1" alt="" src="/documents/10157/1183617/TACC+Taken+-+number+generation/724544eb-d3fc-48a9-9ff1-3f2565c0c46e?t=1463694034600" style="width: 160px; height: 284px;" />
				%figcaption
					Figure 6b.
					%br TACC Token App token code

#international
	:markdown
		# [International Users and Travelers](#international)

		Users located outside the U.S. **must** pair using a [Multi-Factor Authentication app](#mfaapps) of your choice. Because the cost associated with sending multiple international text messages is prohibitive, international users may NOT set up multi-factor authentication with SMS.  

#unpair
	:markdown
		# [Unpairing your Device](#unpair)

		To unpair your device, sign into the TACC User Portal and click on "Manage Profile".  Depending upon the method of pairing you'll see a message similar to Figure 7.  Click on the red subtract symbol to begin the unpairing process.

	%figure
		<img src="/documents/10157/1183617/MFA-unpair.png/cd9fd03d-9480-453d-993c-067f7fe3c0bc?t=1473772449982" style="border-width: 1px; border-style: solid; height: 152px; width: 200px;" /></p>
		%figcaption
			Figure 7.
			%br Profile configured with SMS pairing

	:markdown
		On the next screen (Figure 8.) you'll be asked to to confirm the unpairing.  Similar to the pairing process, you must verify unpairing by entering the token code when prompted.  If you've lost access to the device you originally paired with, you may unpair using email notification.


	%figure
		<img border="1" alt="SMS Unpairing" src="/documents/10157/1183617/SMS+unpairing.png/774eef39-898d-4ff6-b52e-63d7f1830269?t=1463760842817" style="width: 550px; height: 350px;" />
		%figcaption
			Figure 8.
			%br Unpairing TACC Token App or SMS pairings

