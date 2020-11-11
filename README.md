Mysql Dockerfile:

I created a customized Mysql Docker Image to add Database and specific user for Mediawiki to use 
1.	Dockerfile for Mysql is added in mysql folder
2.	This will create Mysql and during bootup it will use the execute the Query file added in sql-scripts folder



Mysql as stateful sets: 

I created the Sattefulset for Mysql as this supports the Master slave concept and Autoscaling of Pods is possible also this supports Data Redudency

1.	I first tried to create Hostpath as PV and add Nodeaffinity for Pod specs and PV specs so that Pods and Volumes reside in same node.
2.	But this did not work as Slave nodes were not able to start because Volumes of Hostpath cannot be shared by all Pods as Innodb error will come. ( PV and PVC is added in mysql Directory )
3.	So moved to Dyanamic provision of Volumes using Storage class for AzureDisk, thus Statefulset of Mysql for all required pods got their own share of Volmes Dynamically.
(Storageclass Yaml for Azuredisk is added Removed the auth Part)
4.	I even tested this for AWS ELB it worked.
5.	Image name  has to be modified with New customized docker image
6.	Created Headless service for Mysql 
7.	Created one more service only Write ( this can be configured in application to used only write activity , did not use it as Mediawiki do not support it)


MediaWiki:

I created Mediawiki Image with Apache and Php with Mediawiki package.
1.	Installed Apache
2.	Installed Php 7.3 version
3.	Installed Mediawiki 
4.	Mediawiki Dynamic configuration was tricky as we need to send Database settings during Bootup itself
5.	Added Localsettings.php file with Mysql details ( Added Mysql Service name )


Mediawiki as Deployment:

1.	I created Deployment for Mediawiki as this is a now designed as stateless  ( DB Stateful set has to be running before the deployment of Mediawiki)
2.	Service  created with Nodeport



HELM :

1. Deployment and statefulset is added ( did not work as espected as statefull has to start before Deployment)
2. need to create two seperate chart 
3. Mysql should be added as dependecies chart in Mediawiki chart ( will try this )

CI/CD :

This above steps is easy to intergrate with CI/CD as Mediawiki application part is segregated from DB 

Blue green Deployemnt:

1. Will work as in helm chart i have added the image of  mediawiki  in values yaml 
2. CI/CD itself can handle Blue/green deployment of mediawiki 
