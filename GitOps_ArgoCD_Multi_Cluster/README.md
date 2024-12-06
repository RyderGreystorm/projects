9. Log Into argocd cli. 
You now need to connect the spoke clusters to the hub cluster. This cannot be done through the UI. You will need to do this on the cli. Also as a devops engineer, try to use the cli as much as possible. First let us log into the cli. Please refer to file 01_prerequisites.md to see how to install the argocd cli. 
`argocd login <hub_publicip:port>`

10. Add clusters:
You will need to get the context of these clustes and agian copy and paste all the authids of each cluster you want to connect to your hub.
`kubectl config get-contexts`
For now we will add these clusters one at a time. In my case, i have three clusters to i will run

`argocd add yourprofile@cluster1-cluster.us-region-az --server <hub_publicip:port>`
`argocd add yourprofile@cluster2-cluster.us-region-az --server <hub_publicip:port>`
`argocd add yourprofile@cluster3-cluster.us-region-az --server <hub_publicip:port>`

Go to your argocd web ui, settings => clusters, you will see all the clusters there.


