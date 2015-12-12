#!/usr/bin/python
from pygeocoder import Geocoder
import argparse


# Define commandline arguments
parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,description='Geolocation resolver for Zabbix. Will return a value of 255 for any non-successful lookups.')
parser.add_argument("mode", help='Resolution mode, "long" for longitude, "lat" for latitude, or "geo" for both.', choices=['geo', 'lat', 'long'])
parser.add_argument("location", help='Human readable Location to resolve to GeoLocation coordinates.')
args = parser.parse_args()

try:
 results = Geocoder.geocode(args.location)

except:
 print "255"
 exit("Something went wrong.")

if args.mode == 'lat':
  print results[0].coordinates[0]

if args.mode == 'long':
  print results[0].coordinates[1]

if args.mode == 'geo':
  print str(results[0].coordinates[0]) + " " + str(results[0].coordinates[1])


