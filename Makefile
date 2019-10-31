.PHONY: install uninstall reinstall

install: apt-fast completions/bash/apt-fast
	apt-get install --force-yes -y -qq aria2
	cp apt-fast /data/data/com.termux/files/usr/bin/
	cp apt-fast.conf /data/data/com.termux/files/usr/etc/
	mkdir -p /data/data/com.termux/files/usr/etc/bash_completion.d/
	mkdir -p /data/data/com.termux/files/usr/share/zsh/functions/Completion/Debian/
	cp completions/bash/apt-fast /data/data/com.termux/files/usr/etc/bash_completion.d/
	cp completions/zsh/_apt-fast /data/data/com.termux/files/usr/share/zsh/functions/Completion/Debian/
	mkdir -p /data/data/com.termux/files/usr/share/man/man8/
	mkdir -p /data/data/com.termux/files/usr/share/man/man5/
	cp man/apt-fast.8 /data/data/com.termux/files/usr/share/man/man8/
	cp man/apt-fast.conf.5 /data/data/com.termux/files/usr/share/man/man5/
	gzip -f9 /data/data/com.termux/files/usr/share/man/man8/apt-fast.8
	gzip -f9 /data/data/com.termux/files/usr/share/man/man5/apt-fast.conf.5

uninstall: /data/data/com.termux/files/usr/bin/apt-fast
	rm -rf /data/data/com.termux/files/usr/bin/apt-fast /data/data/com.termux/files/usr/etc/apt-fast.conf \
	/data/data/com.termux/files/usr/share/man/man5/apt-fast.conf.5.gz /data/data/com.termux/files/usr/share/man/man8/apt-fast.8.gz \
	/data/data/com.termux/files/usr/share/zsh/functions/Completion/Debian/_apt-fast /data/data/com.termux/files/usr/etc/bash_completion.d/apt-fast
	@echo "Please manually remove deb package - aria2 if you don't need it anymore."

/data/data/com.termux/files/usr/bin/apt-fast:
	@echo "Not installed" 1>&2
	@exit 1

reinstall: uninstall install
