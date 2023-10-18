# .bash_profile

# Source global profile
[ -f /etc/profile ] && . /etc/profile

# Source user-specific  settings
if [ -d ~/.profile.d/ ]; then
	for rcfile in ~/.profile.d/*.sh; do
		. "${rcfile}"
	done
fi
