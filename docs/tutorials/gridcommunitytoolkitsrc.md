<p><span style="font-size:225%; font-weight:bold;">Using Grid Community Toolkit at TACC</span><br>
<i>Last update: September 1, 2022</i> </p>

#top
	:markdown

		TACC users now have access to Grid Community Toolkit and the Grid Community Toolkit utilities to transfer files directly into and out of TACC systems. This new feature allows users to associate new Distinguished Names (DNs) with their TACC account, thereby allowing TACC users access to [Grid Community Toolkit](http://globus.org) to transfer files.

		In order to transfer files using Grid Community Toolkit you will need to:

		1. [Find a DN](#step1)
		2. [Add the DN to your TACC Profile](#step2)
		3. [Activate the Grid Community Toolkit Endpoints](#step3)
		4. [Transfer Files](#step4)

#step1
	:markdown
		## [Step 1: Find a DN from a MyProxy or MyProxy OAuth provider](#step1)

		To create a DN, you need to log in from some authoritative source that can verify your identity, typically your university or employer. If you already have a DN from another source, you can use that. If you do not, you can associate one with your account from many of the major universities in the world via the "CI Logon" service.

		<p class="portlet-msg-info">You must use your institution’s credentials and not your personal Google account when setting up Grid Community Toolkit. If you use a personal account, you will encounter an issue with the endpoint.</p>

		Grid Community Toolkit supports MyProxy and MyProxy OAuth identity providers. While you should be able to use any MyProxy/MyProxy OAuth provider, for this documentation we will be using [CILogon.org](https://cilogon.org/).

		To retrieve your DN, go to [https://cilogon.org](https://cilogon.org/) in your browser. Select an Identity Provider from the drop-down list and click "Log On".

		<img alt="" src="/documents/10157/1201625/img01.png/83b98103-cb2e-4bc6-ba3f-7df8dd446af2?t=1433868565403" style="width: 600px; height: 624px;" />

		We have selected "University of Texas at Austin". After successfully authenticating at your chosen identity provider, you are redirected back to CILogon, where you can see your certificate subject:

		`/DC=org/DC=cilogon/C=US/O=University of Texas at Austin/CN=Sample Person A00000` 

		This is the data you need to associate with your TACC account.

		<img alt="" src="/documents/10157/1201625/img02.png/87f3557c-c1a5-4771-8603-b964861e0306?t=1433868565125" style="width: 600px; height: 624px;" />


#step2
	:markdown
		## [Step 2: Associate the DN with our TACC Account](#step2)

		Login to the [TACC User Portal](https://portal.tacc.utexas.edu) and click "Manage your Profile" from the Dashboard actions or select "Account Profile" from the main menu under the "Home" dropdown. You can also navigate directly to [https://portal.tacc.utexas.edu/account-profile](https://portal.tacc.utexas.edu/account-profile). On the left of the page is a list of account actions, select "Manage DNs". You will be presented with a list of the DNs currently associated with your TACC account.

		<img alt="" src="/documents/10157/1201625/img03.png/470059a8-693b-4b62-bdca-00072ed4b4a5?t=1433868564546" style="height: 624px; width: 600px;" />

		On the Manage DNs page, near the bottom, is a form to associate a DN to your account. Enter the Certificate Subject obtained from CILogon.org in the text field. Click the button to "Associate DN". This will associate the new DN with your account. 


		<img alt="" src="/documents/10157/1201625/img04.png/658f2793-75bc-4371-a09e-fd03dac26ae9?t=1433868564841" style="height: 625px; width: 600px;" />

		<p class="portlet-msg-alert">Please note, it may take up to 30 minutes for this change to propagate to all TACC systems.</p>

		<img alt="" src="/documents/10157/1201625/img05.png/12fcdd5e-fb2f-4562-bc29-1bba0951a283?t=1433868564258" style="width: 600px; height: 624px;" />

#step3
	:markdown
		## [Step 3: Activate Grid Community Toolkit Endpoints](#step3)

		Now that you have associated the DN with your TACC account **and** given the DN time to propagate to the systems (up to thirty minutes), you can activate the Grid Community Toolkit transfer endpoints and begin transferring files.


		Go to [https://globus.org](https://globus.org), log in, and click "Manage Data". Alternatively, navigate directly to [https://app.globus.org/file-manager](https://app.globus.org/file-manager). In one of the transfer endpoint form boxes, search for endpoints prefixed "`tacc#`". For example, you should be able to find "`tacc#stampede2`". 


		<img alt="" src="/documents/10157/1201625/img06.png/692f0431-2edc-4037-988f-0f7b515f980e?t=1433868563963" style="width: 600px; height: 624px;" />

		After selecting the endpoint you'll be prompted to authenticate in order to active the endpoint. Click "`Continue`" and you will be redirected to a Grid Community Toolkit-branded CILogon authentication page. Select the same identity provider that you used when you retrieved your certificate above and re-authenticate. 


		<img alt="" src="/documents/10157/1201625/img07.png/53f126fb-de37-4239-9db2-8ec0c4277735?t=1433868563671" style="width: 600px; height: 624px;" />


#step4
	:markdown
		## [Step 4: Transfer Files](#step4)

		After successfully authenticating, you will be redirected back to Grid Community Toolkit and you will now be able to access your data on Stampede2.

		<img alt="" src="/documents/10157/1201625/img08.png/4620952d-9c8d-49d9-bca3-7ddf6e270fdd?t=1433868562741" style="width: 600px; height: 624px;" />


