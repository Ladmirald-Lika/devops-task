#Install Helm: 

curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# Add repo and Install

helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install jenkins jenkins/jenkins > /var/log/helm.txt

# This will create a Kubernetes deployment with one replica and a service for accessing the Jenkins web UI.
# Please read the log at /var/log/helm.txt and you will find details to access Jenkins
# Use kubectl get svc jenkins  to find how it is exposed 
# Find Password of Jenkins Admin 
#Access the Jenkins web UI:
# check IP and password from step above
# Access it on Web and config it 
# http://<jenkins-ip-address>:<jenkins-port>
