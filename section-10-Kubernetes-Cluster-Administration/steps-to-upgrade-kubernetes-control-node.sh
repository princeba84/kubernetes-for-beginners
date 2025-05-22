# Steps to upgrade Kubernetes control plane node :

# Setting up (Changing)  apt repository:

sudo curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | \
	sudo tee /etc/apt/sources.list.d/kubernetes.list




# Upgrading kubeadm ,kubelet and kubectl (Execute commands as root user or with sudo)
      
sudo apt-mark unhold kubeadm kubectl kubelet
sudo apt-get update   
sudo apt --fix-broken install -y
sudo apt-get install -y kubeadm=1.32.5-1.1 kubectl=1.32.5-1.1 kubelet=1.32.5-1.1  #If it fails , execute apt --fix-broken install 
sudo apt list -a kubeadm   # To check available versions
sudo apt-mark hold kubeadm kubectl kubelet
       
sudo kubeadm upgrade plan
sudo kubeadm upgrade apply v1.32.5 -y
sudo kubeadm version


# Restart kubelet :

sudo systemctl restart kubelet
sudo systemctl status kubelet  #To check status after restart

# Verify version: 

kubectl get nodes
kubelet --version
kubectl version
#Verify image version of control plane components at path /etc/kubernetes/manifests/ #

# In case of HA setup (e.g., 3 control plane nodes ), repeat all steps for other control plane nodes and execute command

# kubeadm upgrade node instead of kubeadm upgrade apply command.
