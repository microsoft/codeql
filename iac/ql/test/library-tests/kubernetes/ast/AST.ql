private import iac

query predicate documents(YamlKubernetes::Document n) { any() }
query predicate metadata(YamlKubernetes::Metadata n) { any() }
query predicate podSpecs(YamlKubernetes::PodSpec n) { any() }
query predicate containers(YamlKubernetes::Container n) { any() }
query predicate env(YamlKubernetes::EnvEntry n) { any() }
query predicate security(YamlKubernetes::SecurityContext n) { any() }
query predicate volumes(YamlKubernetes::Volume n) { any() }
query predicate roles(YamlKubernetes::Role n) { any() }
query predicate rules(YamlKubernetes::Rule n) { any() }
query predicate bindings(YamlKubernetes::RoleBinding n) { any() }
query predicate subjects(YamlKubernetes::Subject n) { any() }
