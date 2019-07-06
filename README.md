# is2um
My essential installation for development to Ubuntu Minimal
* [Criar pendrive](https://www.reddit.com/user/nenitfate/comments/bcm30b/criar_pendrive_bootavel_no_ubuntu/)

## Installation
```bash
wget -O- http://neni.dev/is2um/lazy.sh | sh
```

## Force Update
```bash
git fetch --all
git reset --hard origin/master
```

## Todo
- [ ] Cancelar download em caso de falha e especificar o erro
- [ ] Omitir "A preparar/descompatar/selecionar" e etc do apt-get install. Tornar claro o que está sendo baixado mas com menos logs
- [ ] Add percentual% atual da instalação e sua atualização, isso depende da quantidade de cenarios de download
- [ ] Instalar emojis coloridos para ver no st, dwm e dmenu
