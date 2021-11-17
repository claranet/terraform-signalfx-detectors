# Contributing

__Thanks for wanting to contribute. The Claranet Team will be pleased to guide you and review
your proposals as quickly as possible. Keep in mind that all communication are
subject to our [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).__

To record a bug report, enhancement proposal, or give any other product feedback, please [open
a new Github issue](https://github.com/claranet/terraform-signalfx-detectors/issues/new/choose)
using the most appropriate issue template. Please, try to provide as much details, context and
examples as possible. Information requested by issue templates should help but feel free to
adapt. The goal is to maximize chance to act relevantly to your feedback.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Workflow](#workflow)
  - [Issue](#issue)
  - [Pull Request](#pull-request)
  - [Speed up review and merge](#speed-up-review-and-merge)
- [Changes types](#changes-types)
  - [Documentation](#documentation)
  - [Detectors](#detectors)
  - [Templating](#templating)
  - [Continuous Integration](#continuous-integration)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Workflow

In general, we prefer to discuss in Github issues prior to implementation. That will allow us to
give some clues and recommendations on the design and may be provide existing work or thoughts
from our experience.

But depending of the scope and the size of the change and how you feel confident about it, do
know well the code base, and do not need help feel free to go to the next step directly.

### Issue

First, search for existing issue related to your change and start a discussion about what you
wish to implement. This could be useful to prevent implicit conflicts, notice eventual
implications or mutualise implementation of dependent or similar features.

If you did not find an existing one, please [open a new Github
issue](https://github.com/claranet/terraform-signalfx-detectors/issues/new/choose)
before invest significant development time.

### Pull Request

1. You are welcome to submit a [draft pull
request](https://github.blog/2019-02-14-introducing-draft-pull-requests/)
for commentary or review before it is fully completed. It's also a good idea to include specific
questions or items you'd like feedback on.
2. Once you believe your pull request is ready to be merged you can create your pull request.
3. When time permits Claranet Team members will look over your contribution and either merge, or
provide comments letting you know if there is anything left to do. It may take some time for us
to respond. We may also have questions that we need answered about the code, either because
something doesn't make sense to us or because we want to understand your thought process.
4. If we have requested changes, you can either make those changes or, if you disagree with
the suggested changes, we can have a conversation about our reasoning and agree on a path
forward. This may be a multi-step process. Our view is that pull requests are a chance to
collaborate, and we welcome conversations about how to do things better. It is the contributor's
responsibility to address any changes requested. While reviewers are happy to give guidance,
it is unsustainable for us to perform the coding work necessary to get a PR into a mergeable state.
5. Once all outstanding comments and checklist items have been addressed, your contribution will
be merged and should be included in the next release!
6. In some cases, we might decide that a PR should be closed without merging. We'll make sure to
provide clear reasoning when this happens. Following the recommended process above is one of the
ways to ensure you don't spend time on a PR we can't or won't merge.

### Speed up review and merge

It is much easier to review pull requests that are:

1. Well-documented: Try to explain in the pull request comments what your change does, why you have
made the change, and provide instructions for how to produce the new behavior introduced in the pull
request. If you can, provide screen captures or terminal output to show what the changes look like.
This helps the reviewers understand and test the change. This peace could belongs in existing Github
issue. In this case, add `fix #ISSUE_ID` in the Pull Request description. You can also add the
`#ISSUE_ID` in your commits.
2. Small: Try to only make one change per pull request. If you found two bugs and want to fix them
both, that's *awesome*, but it's still best to submit the fixes as separate pull requests. This
makes it much easier for reviewers to keep in their heads all of the implications of individual
code changes, and that means the PR takes less effort and energy to merge. In general, the smaller
the pull request, the sooner reviewers will be able to make time to review it.
3. Passing Tests: Based on how much time we have, we may not review pull requests which aren't
passing our tests (look below for advice on how to run unit tests). If you need help figuring out
why tests are failing, please feel free to ask, but while we're happy to give guidance it is
generally your responsibility to make sure that tests are passing.

If we request changes, try to make those changes in a timely manner. Otherwise, PRs can go stale
and be a lot more work for all of us to merge in the future.

Even with everyone making their best effort to be responsive, it can be time-consuming to get a
PR merged. It can be frustrating to deal with the back-and-forth as we make sure that we understand
the changes fully. Please bear with us, and please know that we appreciate the time and energy you
put into the project.

## Changes types

The general workflow is the same for any contribution but there are different considerations to
know depending on what you want to change or, more specifically, on what could be impacted by
your change.

### Documentation

__Label__:
[documentation](https://github.com/claranet/terraform-signalfx-detectors/labels/documentation)

__Issue__: Not required, go ahead and open a Pull Request.

Changes of documentation are safe but table of contents and modules readmes are generated,
please follow the [development's guide](docs/development.md#documentation).

Pull request is not possible on Github `wiki` so you can create an issue and if it is too
complex to explain you can:

1. create a new empty repository on your Github
1. clone this wiki `git clone git@github.com:claranet/terraform-signalfx-detectors.wiki.git`
1. change its remote to your new repository `git remote set-url origin https://github.com/USERNAME/REPOSITORY.git`
1. push your change to your repository
1. provide the change "compare" or "pr" url of your Github repository in this issue.

### Detectors

__Label__:
[detectors](https://github.com/claranet/terraform-signalfx-detectors/labels/detectors)

__Issue__: Not required but recommended.

Changes on detectors are the most common but you first have to understand the current goal of
this repository explained in the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki).
Indeed, this repository aims to provide "generic enough" detectors and this limits the scope of changes we
can accept.

Now, please follow the [development's guide](docs/development.md#detectors).

Globally, we want modules to be as much "plug and play" as possible, that means:

* be easy to configure and deploy
* works in most of the situations
* do not generate undesirable and predictable false alerts
* how to collect the metrics used in detectors should be provided, documented and available.
* should limit dependencies complexity as using too many or too different sources of metrics.

In short, the implementation could be complex but the usage must remain simple and useful for the
community. To make it possible we provide a common module
[structure](https://github.com/claranet/terraform-signalfx-detectors/wiki/Structure) which make
the experience similar for every modules.

Sadly, full ready and generic detectors which work everywhere by default is almost never possible.
This is why we have also have use
[templating](https://github.com/claranet/terraform-signalfx-detectors/wiki/Structure) thanks to
terraform to make it possible to customize their configuration and adapt their behavior at deployment.

This is why all modules must provide, at least, these Terraform
[variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) to enjoy this
templating and provide to the user common customization capabilities.

### Templating

__Label__:
[templating](https://github.com/claranet/terraform-signalfx-detectors/labels/templating)

__Issue__: Mandatory

This project respect some rules to create the modules and their detectors. It is constraining and
will eventually limit the usage in some cases but this allows to preserve homogeneity in
implementation, parity in features and it brings a common, repeatable and opinionated way to deploy,
configure and manage detectors.

We want this template evolves from internal usage and community feedback to cover a larger scope of
usage and provide more flexibility in implementation. However, monitoring is a critical component for
most of the people and it is crucial for us to preserve the reliability of the underlying detectors.

Too many customization mechanisms fatally involve more complexity and make the code more difficult
to understand, review, maintain, test and to contribute to it. Sometimes we will prefer to abandon a
feature to keep it simple if it concerns to few users or implies too tricky or dangerous consequences.

That said, please open an issue to discuss, this could help us to notice and prioritize some popular
features. And if you want to try to implement it yourself this could be the place to provide you help
and resources. In this case, please follow the [development's guide](docs/development.md#templating).

At this time, we do not have a formal process for reviewing proposals that significantly change this
project, its primary usage patterns, and its defined template. Additionally, some seemingly simple
proposals can be difficult or time consuming to spread over every modules.

### Continuous Integration

__Label__:
[CI](https://github.com/claranet/terraform-signalfx-detectors/labels/CI)

__Issue__: Highly recommended because it could have deep implications but not required for simple
changes.

CI related changes will generally be done by Claranet Team but if you try to implement an important
templating change as mentioned just above there is good chance you will need to update existing
tests or add new ones for your feature.

Please ask to help and advice about this because the workflow could be not obvious but you can
check the [development's guide](docs/development.md#checks).
