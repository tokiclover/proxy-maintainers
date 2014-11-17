proxy-maintainers
=================

#### This overlay is not intended to be cloned via layman, but just another way to contribute to Gentoo.

The proxy-maintainers project helps users to take care of packages that lack a maintainer with direct access to the tree. 
Users are encouraged to maintain packages, that are assigned to 'maintainer-needed@gentoo.org'. Here is a list of [orphaned packages](http://www.gentoo.org/proj/en/qa/treecleaners/maintainer-needed.xml).


### Workflow

If you're currently a proxied maintainer for a certain package and want to push an update to the tree, please fork this repository and create a pull request. Updates concerning KEYWORDS (i.e. stabilization) should be handled by the appropriate arch teams on [bugs.gentoo.org](https://bugs.gentoo.org).

The members of the proxy maintainers project will review your pull request, __merge__ it and move the changes into the tree.

If you're currently not a proxied maintainer, please contact the project first either via mail ( <proxy-maint@gentoo.org> ) or via [bugs.gentoo.org](https://bugs.gentoo.org).


### Repoman status

[![Repoman Status](https://travis-ci.org/gentoo/proxy-maintainers.png)](https://travis-ci.org/gentoo/proxy-maintainers)
