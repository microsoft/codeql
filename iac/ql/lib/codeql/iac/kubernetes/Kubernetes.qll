private import codeql.iac.YAML
private import codeql.files.FileSystem

/**
 * Structural model for Kubernetes YAML manifests.
 *
 * The model intentionally covers locally observable workload and RBAC
 * structure. It does not attempt to resolve admission policies, rendered Helm
 * values, or cluster-level defaults.
 */
module YamlKubernetes {
  class Document extends YamlNode, YamlDocument, YamlMapping {
    Document() {
      this.getFile().getExtension() = ["yml", "yaml"] and
      exists(this.lookup("apiVersion")) and
      exists(this.lookup("kind"))
    }

    override string toString() { result = "Kubernetes " + this.getKind() + " document" }

    string getApiVersion() { result = yamlToString(this.lookup("apiVersion")) }

    string getKind() { result = yamlToString(this.lookup("kind")) }

    Metadata getMetadata() { result = this.lookup("metadata") }

    YamlMapping getSpec() { result = this.lookup("spec") }

    PodSpec getPodSpec() {
      result = this.getSpec().(PodSpec)
      or
      result = this.getSpec().lookup("template").(YamlMapping).lookup("spec").(PodSpec)
      or
      result = this.getSpec().lookup("jobTemplate").(YamlMapping).lookup("spec").(YamlMapping)
        .lookup("template").(YamlMapping).lookup("spec").(PodSpec)
    }

    Container getContainers() { result = this.getPodSpec().getContainers() }

    Container getInitContainers() { result = this.getPodSpec().getInitContainers() }

    Container getEphemeralContainers() { result = this.getPodSpec().getEphemeralContainers() }
  }

  class Metadata extends YamlNode, YamlMapping {
    Metadata() { exists(Document document | document.lookup("metadata") = this) }

    string getName() { result = yamlToString(this.lookup("name")) }

    string getNamespace() { result = yamlToString(this.lookup("namespace")) }

    YamlValue getLabels() { result = this.lookup("labels") }

    YamlValue getAnnotations() { result = this.lookup("annotations") }
  }

  class PodSpec extends YamlNode, YamlMapping {
    PodSpec() {
      exists(Document document | document.getSpec() = this)
      or
      exists(YamlMapping template | template.lookup("spec") = this)
    }

    Container getContainers() { result = this.lookup("containers").(YamlSequence).getAChild() }

    Container getInitContainers() {
      result = this.lookup("initContainers").(YamlSequence).getAChild()
    }

    Container getEphemeralContainers() {
      result = this.lookup("ephemeralContainers").(YamlSequence).getAChild()
    }

    SecurityContext getSecurityContext() { result = this.lookup("securityContext") }

    YamlValue getServiceAccountName() { result = this.lookup("serviceAccountName") }

    YamlValue getAutomountServiceAccountToken() {
      result = this.lookup("automountServiceAccountToken")
    }

    Volume getVolumes() { result = this.lookup("volumes").(YamlSequence).getAChild() }

    YamlValue getHostNetwork() { result = this.lookup("hostNetwork") }

    YamlValue getHostPid() { result = this.lookup("hostPID") }

    YamlValue getHostIpc() { result = this.lookup("hostIPC") }
  }

  class Container extends YamlNode, YamlMapping {
    Container() {
      exists(PodSpec pod | pod.lookup("containers").(YamlSequence).getAChildNode() = this)
      or
      exists(PodSpec pod | pod.lookup("initContainers").(YamlSequence).getAChildNode() = this)
      or
      exists(PodSpec pod | pod.lookup("ephemeralContainers").(YamlSequence).getAChildNode() = this)
    }

    string getName() { result = yamlToString(this.lookup("name")) }

    string getImage() { result = yamlToString(this.lookup("image")) }

    SecurityContext getSecurityContext() { result = this.lookup("securityContext") }

    YamlValue getCommand() { result = this.lookup("command") }

    YamlValue getArgs() { result = this.lookup("args") }

    YamlValue getEnv() { result = this.lookup("env") }

    EnvEntry getEnvironmentEntries() { result = this.lookup("env").(YamlSequence).getAChild() }

    YamlValue getEnvFrom() { result = this.lookup("envFrom") }

    YamlValue getVolumeMounts() { result = this.lookup("volumeMounts") }

    YamlValue getPorts() { result = this.lookup("ports") }
  }

  class EnvEntry extends YamlNode, YamlMapping {
    EnvEntry() {
      exists(Container container | container.lookup("env").(YamlSequence).getAChildNode() = this)
    }

    string getName() { result = yamlToString(this.lookup("name")) }

    YamlValue getValue() { result = this.lookup("value") }

    YamlMapping getValueFrom() { result = this.lookup("valueFrom") }

    YamlMapping getSecretKeyRef() { result = this.getValueFrom().lookup("secretKeyRef") }

    YamlMapping getConfigMapKeyRef() { result = this.getValueFrom().lookup("configMapKeyRef") }
  }

  class SecurityContext extends YamlNode, YamlMapping {
    SecurityContext() {
      exists(PodSpec pod | pod.lookup("securityContext") = this)
      or
      exists(Container container | container.lookup("securityContext") = this)
    }

    YamlValue getPrivileged() { result = this.lookup("privileged") }

    YamlValue getAllowPrivilegeEscalation() {
      result = this.lookup("allowPrivilegeEscalation")
    }

    YamlValue getRunAsUser() { result = this.lookup("runAsUser") }

    YamlValue getRunAsGroup() { result = this.lookup("runAsGroup") }

    YamlValue getRunAsNonRoot() { result = this.lookup("runAsNonRoot") }

    YamlValue getReadOnlyRootFilesystem() {
      result = this.lookup("readOnlyRootFilesystem")
    }

    YamlValue getCapabilities() { result = this.lookup("capabilities") }

    YamlValue getSeccompProfile() { result = this.lookup("seccompProfile") }
  }

  class Volume extends YamlNode, YamlMapping {
    Volume() { exists(PodSpec pod | pod.lookup("volumes").(YamlSequence).getAChildNode() = this) }

    string getName() { result = yamlToString(this.lookup("name")) }

    YamlValue getHostPath() { result = this.lookup("hostPath") }

    YamlValue getProjected() { result = this.lookup("projected") }

    YamlValue getSecret() { result = this.lookup("secret") }

    YamlValue getConfigMap() { result = this.lookup("configMap") }
  }

  class Role extends Document {
    Role() { this.getKind() = ["Role", "ClusterRole"] }

    Rule getRules() { result = this.getSpec().lookup("rules").(YamlSequence).getAChild() }
  }

  class Rule extends YamlNode, YamlMapping {
    Rule() { exists(Role role | role.getSpec().lookup("rules").(YamlSequence).getAChildNode() = this) }

    YamlValue getApiGroups() { result = this.lookup("apiGroups") }

    YamlValue getResources() { result = this.lookup("resources") }

    YamlValue getVerbs() { result = this.lookup("verbs") }

    YamlValue getResourceNames() { result = this.lookup("resourceNames") }
  }

  class RoleBinding extends Document {
    RoleBinding() { this.getKind() = ["RoleBinding", "ClusterRoleBinding"] }

    YamlMapping getRoleRef() { result = this.getSpec().lookup("roleRef") }

    Subject getSubjects() { result = this.getSpec().lookup("subjects").(YamlSequence).getAChild() }
  }

  class Subject extends YamlNode, YamlMapping {
    Subject() {
      exists(RoleBinding binding |
        binding.getSpec().lookup("subjects").(YamlSequence).getAChildNode() = this
      )
    }

    string getKind() { result = yamlToString(this.lookup("kind")) }

    string getName() { result = yamlToString(this.lookup("name")) }

    string getNamespace() { result = yamlToString(this.lookup("namespace")) }
  }
}
