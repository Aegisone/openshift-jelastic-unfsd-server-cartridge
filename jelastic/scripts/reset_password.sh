#!/bin/bash

SED=$(which sed);

#
# This is an example of reset password hook in Jelastic
#

#$J_OPENSHIFT_APP_ADM_USER        ;   Operate this variable for the username
#$J_OPENSHIFT_APP_ADM_PASSWORD    ;   Use this varible for your password

function _setPassword() {
	echo -e "$J_OPENSHIFT_APP_ADM_PASSWORD\n$J_OPENSHIFT_APP_ADM_PASSWORD" | passwd
	return $?;
}





