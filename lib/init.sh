#!/bin/bash
#
# $Id: lib/init.sh 3.24 2017-10-21 00:47:23 rob.navarro $
#
# init.sh
# contains functions to change user and run processes
# 
# also, common code for the init scripts.
#
# Copyright 2016 AppDynamics, Inc
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
# 

# enable Debian systems to work also
function service {
    if [[ -z "$service_bin" ]] ; then
        if [[ -f /sbin/service ]] ; then
                service_bin=/sbin/service
        elif [[ -f /usr/sbin/service ]] ; then
                service_bin=/usr/sbin/service
        else
            echo service not found in /sbin or /usr/sbin - exiting
            exit 13
        fi
        $service_bin "$@"
    else
        $service_bin "$@"
    fi
}

function require_root {
    if [ `id -un` != "root" ] ; then
        echo "service changes must be run as root"
        exit 1
    fi
}

#
# trivial sanity check
#
function check_sanity {
	if runuser [ ! -f $APPD_ROOT/db/db.cnf ] ; then
		echo appd controller not installed in $APPD_ROOT
		exit 1
	fi
	if runuser [ ! -x $APPD_ROOT/bin/controller.sh ] ; then
		echo controller disabled on this host
		exit 1
	fi
}

