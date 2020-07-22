# OpCon Reports ps
A PowerShell script that runs OpCon reports in batch mode, allowing the user to get the PDF result attached to an email.

# Prerequisites
* Any OpCon supported version (latest version preferred)
* Powershell 7.0+ (https://github.com/PowerShell/PowerShell)

# Optional (Desirable)
* OpCon Self-Service

# Instructions
* Steps for Script and Job Setup

Paste or import the script into the OpCon Scripts Repository and add a job into a Schedule.
The script has several different parameters, allowing the user to use it without having to make too many changes.
There are only 2 required parameters: -ReportName and -password (this is the password of the account that will send the email).
Check the OpCon documentation for more information on report names (Ex: Comparative Job Execution Statistics => admin03)
The following line shows an example of the Arguments field in the Job Details tab (in this case we are using Instance Properties):

```
        -SkdDateIni "[[JI.DATEINI]]" -SkdDateEnd "[[JI.DATEEND]]" -Schedule "[[JI.SCHEDULE]]" -ReportName "[[JI.REPORT]]" -password [[EMAILPASSWORD]] -to "[[JI.EMAIL]]" -SendEmail [[JI.SENDEMAIL]]
```

Add an On Request frequency.

* Steps for Self-Service (Optional)

If desired, the user can setup a Self-Service button to run this report.
Create the button that will have an event like this:

```
        $JOB:ADD,CURRENT,<Schedule name>,<Job Name>,<Frequency name>,Report=${REPORT};Schedule=${SCHEDULE};DateINI=${DATEINI};DateEnd=${DATEEND};EMAIL=${SM.USER.EMAIL};SENDEMAIL=${SENDEMAIL}
```
Where:
Report=${REPORT} (Required field) is a List field that contains a list of the reports;
SENDEMAIL=${SENDEMAIL} (Required field) is a List field that must contain Yes and No as options to tell the script to send the email with the PDF file or not; 
Schedule=${SCHEDULE} is a Schedule Master field;
DateINI=${DATEINI} is a Date field that can be used as starting date for the information in the report;
DateEnd=${DATEEND} is a Date field that can be used as the end date for the information in the report;
EMAIL=${SM.USER.EMAIL} (can be a field in Self-Service; in this case we are using the current Solution Manager user's email) is the email address of the the person that will get the email;


# Disclaimer
No Support and No Warranty are provided by SMA Technologies for this project and related material. The use of this project's files is on your own risk.

SMA Technologies assumes no liability for damage caused by the usage of any of the files offered here via this Github repository.

# License
Copyright 2020 SMA Technologies

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

# Contributing
We love contributions, please read our [Contribution Guide](CONTRIBUTING.md) to get started!

# Code of Conduct
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](code-of-conduct.md)
SMA Technologies has adopted the [Contributor Covenant](CODE_OF_CONDUCT.md) as its Code of Conduct, and we expect project participants to adhere to it. Please read the [full text](CODE_OF_CONDUCT.md) so that you can understand what actions will and will not be tolerated.