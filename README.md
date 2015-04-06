# Docker instance.

This just uses my salt config -- currently the docker machine clones it
directly, but that's a bit crap.  I should use submodules so that I can see
changes in the salt config locally when I update -- otherwise it doesn't work.
Alternatively I could use ADD and create releases of my salt config...

