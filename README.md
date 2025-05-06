# Implementation of pluralsh/sre-bench

This is meant to be a fully transparent implementation of Plural's SRE bench.  It will exist as documentation of how we're evaluating our own AI capabilities, and any PRs, gitops and terraform code necessary will be referenced from here.

For reference, the spec of all the cases are outlined in https://github.com/pluralsh/sre-bench

## Setup

This is meant to be setup entirely with Plural itself, all you'll need to do is create a git repository and a service pointing to the `/bootstrap` folder of this repo, eg:

```yaml
apiVersion: deployments.plural.sh/v1alpha1
kind: GitRepository
metadata:
  name: sre-bench
  namespace: infra
spec:
  url: https://github.com/pluralsh/sre-bench-impl.git
---
apiVersion: deployments.plural.sh/v1alpha1
kind: ServiceDeployment
metadata:
  name: sre-bench-setup
spec:
  namespace: sre-bench
  git:
    ref: main
    folder: bootstrap
  configuration:
    clusterHandle: <the-cluster-to-use>
  repositoryRef:
    name: sre-bench
    namespace: infra
  clusterRef:
    name: mgmt
    namespace: infra
```

## Structure

The folder structure is as follows:

```
bootstrap/
- {type}/ # referencing the case type, eg kubernetes | terraform | application
- - {case}.yaml
cases/
- {case}/ # the actual implementation of the case
- - ... # any needed yaml/terraform files to implement
```

For now I expect this to be adequate, but it can be revised as needed.