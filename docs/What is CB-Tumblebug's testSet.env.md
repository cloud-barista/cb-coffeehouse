# What is CB-Tumblebug's testSet ?!

I think `testSet.env` is a specification to create an MCIS (that is a group of instances) and it's very useful for me 👍

`testSet.env` provides the useful, investigated information in each cloud. 
With this, it's possible to create your own specification to create an MCIS.

Before creating a specification, I'd like to describe several things in `testSet.env`.

## 1. You can specify the number of CSPs you consider.   

For example, if `NumbCSP=2`, 2 CSPs will be used.
```bash
## Number of CSP types and corresponding regions
NumCSP=2
```

By the `NumCSP`, the blow list will be sequantially accessed from the top.   
For example, if you want to use AWS and GCP, `IndexAWS=$((++IX))` and `IndexGCP=$((++IX))` should be located at 1st and 2nd line.
```bash
## Define sequential test order for cloud types 
# Note: you can change order by replacing lines (automatically assign continuous numbers starting from 1)
IX=0
IndexAWS=$((++IX))
IndexAzure=$((++IX))
IndexGCP=$((++IX))
IndexAlibaba=$((++IX))
IndexMock=$((++IX))
IndexOpenstack=$((++IX))
IndexNCP=$((++IX))
IndexCloudTwin=$((++IX))
IndexCloudit=$((++IX))
IndexTencent=$((++IX))
```

## 2. You can specify the number of regions in a CSP.  
For example, if `NumRegion[$IndexAWS]=2`, 2 regions will be used.
```bash
## Test setting for Regions of Cloud types 
# Note: you can change order by replacing lines (automatically assign continuous numbers starting from 1)

# AWS (Total: 21 Regions / Recommend: 20 Regions)
NumRegion[$IndexAWS]=2
```

By the `NumRegion[$IndexAWS]`, the blow list will be sequantially accessed from the top.   
For example, if you want to use `AwsApSoutheast1` and `AwsUsWest1`, `AwsApSoutheast1=$((++IY))			# Location: Asia Pacific (Singapore)` and `AwsUsWest1=$((++IY))				# Location: US West (N. California)` should be located at 1st and 2nd line.
```bash
IY=0
AwsApSoutheast1=$((++IY))                 # Location: Asia Pacific (Singapore)
AwsCaCentral1=$((++IY))                   # Location: Canada (Central)
AwsUsWest1=$((++IY))                      # Location: US West (N. California)
AwsUsEast1=$((++IY))                      # Location: US East (N. Virginia)
AwsApNortheast1=$((++IY))                 # Location: Asia Pacific (Tokyo)
AwsApSouth1=$((++IY))                     # Location: Asia Pacific (Mumbai)
AwsApSoutheast2=$((++IY))                 # Location: Asia Pacific (Sydney)
AwsEuWest2=$((++IY))                      # Location: Europe (London)
AwsUsEast2=$((++IY))                      # Location: US East (Ohio)
AwsUsWest2=$((++IY))                      # Location: US West (Oregon)
AwsApNortheast3=$((++IY))                 # Location: Asia Pacific (Osaka)
AwsEuCentral1=$((++IY))                   # Location: Europe (Frankfurt)
AwsEuWest1=$((++IY))                      # Location: Europe (Ireland)
AwsEuWest3=$((++IY))                      # Location: Europe (Paris)
AwsEuNorth1=$((++IY))                     # Location: Europe (Stockholm) - No t2.xxx Specs. t3 c5 m5 r5 .. are availble
AwsSaEast1=$((++IY))                      # Location: South America (São Paulo)
AwsApNortheast2=$((++IY))                 # Location: Asia Pacific (Seoul)
AwsApEast1=$((++IY))                      # Location: Asia Pacific (Hong Kong)  -  Opt-In required
AwsMeSouth1=$((++IY))                     # Location: Middle East (Bahrain)  -  Opt-In required
AwsAfSouth1=$((++IY))                     # Location: Africa (Cape Town)  -  Opt-In required
AwsEuSouth1=$((++IY))                     # Location: Europe (Milan)  -  Opt-In required
```

<ins>**In the same manner, you can specify regions and the number of regions for the other CSPs.**</ins> :smile:
