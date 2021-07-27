# A tutorial to deploy a single Kubernetes cluster across Multi-clouds

This article provides **a step by step tutorial to deploy a single Kubernetes cluster across Multi-clouds**.
(Can you imagine an interesting point? :wink:)

The figure below shows the brief concept of this tutorial. 
Public CSPs on the bottom provides virtual machines (VMs). 
Cloud-Barista provides the integrated operation and management of resources related to VMs, and also provides an overlay network.
Thus, an user could configure a single Kubernetes cluster across Multi-clouds.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/127124490-9c66f406-e455-4ad3-91b8-0184ad055157.png" width="80%" height="80%" >
</p>


The figure below depicts the associated Cloud-Barista components from the bottom to the top in order to deploy a Kubernetes cluster across Multi-clouds.

<p align="center">
  <img src="https://user-images.githubusercontent.com/7975459/127101689-333a1355-c01f-41a7-a879-4310cdc105bc.png" width="80%" height="80%" >
</p>


### (Draft) Contents
1. Prepare credentials of each Cloud Service Provider (CSP)
2. Run CB-Spider
3. Run CB-Tumblebug
4. Run cb-network server
5. Deploy cb-network agent
6. Configure a master of Kubernetes
7. Configure nodes of Kuberentes and then join to the master
8. Deploy pods as an example