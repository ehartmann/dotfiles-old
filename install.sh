#!/bin/bash
os="unknown"

if [ "$(uname)" == "Darwin" ]; then
	os="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	os="linux"
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
	os="win"
fi


[ ! -d "${HOME}/.jenv" ] && git clone https://github.com/gcuisinier/jenv.git ~/.jenv
[ ! -d "${HOME}/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
[ ! -d "${HOME}/.sdkman" ] && curl -s http://get.sdkman.io | sh

# rbenv
[ ! -d "${HOME}/.rbenv" ] && git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
[ ! -d "${HOME}/.rbenv/plugins/ruby-build" ] && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
[ ! -d "${HOME}/.rbenv/plugins/rbenv-vars" ] && git clone https://github.com/sstephenson/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
[ ! -d "${HOME}/.rbenv/plugins/rbenv-each" ] && git clone https://github.com/chriseppstein/rbenv-each.git ~/.rbenv/plugins/rbenv-each
[ ! -d "${HOME}/.rbenv/plugins/rbenv-env" ] && git clone https://github.com/ianheggie/rbenv-env.git ~/.rbenv/plugins/rbenv-env
#[ ! -d "${HOME}/.rbenv/plugins/rbenv-bundle-exec" ] && git clone https://github.com/maljub01/rbenv-bundle-exec.git ~/.rbenv/plugins/rbenv-bundle-exec
[ ! -d "${HOME}/.rbenv/plugins/rbenv-default-gems" ] && git clone https://github.com/sstephenson/rbenv-default-gems.git ~/.rbenv/plugins/rbenv-default-gems
[ ! -d "${HOME}/.rbenv/plugins/rbenv-gem-rehash" ] && git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
[ ! -d "${HOME}/.rbenv/plugins/rbenv-aliases" ] && git clone https://github.com/tpope/rbenv-aliases.git ~/.rbenv/plugins/rbenv-aliases
[ ! -d "${HOME}/.rbenv/plugins/rbenv-update" ] && git clone https://github.com/rkh/rbenv-update.git ~/.rbenv/plugins/rbenv-update
[ ! -d "${HOME}/google-cloud-sdk" ] && curl https://sdk.cloud.google.com | bash

cat > ~/.rbenv/default-gems << "EOF"
bundler
git-up
pry
gist
EOF

export PATH="$HOME/.rbenv/bin:$HOME/.jenv/bin:$PATH"
eval "$(rbenv init -)"
eval "$(jenv init -)"

for ruby in 1.9.3-p551 2.2.4 2.3.0 2.4.0-dev  ; do
	[ ! -d "${HOME}/.rbenv/versions/${ruby}" ] && rbenv install ${ruby}
done

case "${os}" in
	linux)
		for java in `ls -d /opt/jdk*` ; do
			[[ ${java} != *_x32 ]] && jenv add ${java}
		done
		;;
	mac)
		echo "Mac"
		;;
	win)
		echo "I don't care!"
		;;
esac


