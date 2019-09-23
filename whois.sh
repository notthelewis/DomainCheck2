#!/bin/bash

whois $1 | sed '25,$ d'
