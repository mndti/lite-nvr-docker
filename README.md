# lite-nvr-docker
- NVR simples para ser usado com o docker através de uma imagem alpine e ffmpeg
- Este projeto foi criado para uso pessoal e decidi compartilhar.

## Como usar?
Baixe a pasta scripts para seu host(windows/linux/etc).
Dentro do host, coloque a pasta com os scripts, onde achar melhor.
Antes, configure as informações no arquivo: **nvr.conf.json**

### Quantas câmeras posso usar?
O script não tem limitação de câmeras, basta adicionar no **nvr.conf.json**
Exemplo:
<pre><code>		{
		  "name": "_cam-1",
		  "name_ha":"nvr_cam_1",
		  "name_ha_friendly":"nvr - cam 1",
		  "ha_icon":"mdi:record-rec",
		  "link": "rtsp://user:pass@ip:554/Streaming/Channels/101"
		},</code></pre>

### Homeassistant
Se você não tiver ou não quiser usar o ha, ignore as configs relacionadas e use `"ha_status": false`
Essa config apenas cria sensores no ha com o status ok/problema. Se desativado, arquivos txt serão usados na pasta path_log.

### Qual o uso de CPU/RAM?
Baixo, pois o script apenas faz o copy do fluxo de vídeo/áudio. Entretanto, se desejar customizar os parametros do ffmpeg, edite o arquivo: `ffmpeg.sh`

## Configurações
- `"seg_time": 300` tamanho do arquivo em segundos padrão 5 minutos
- `"last_mod_minutes": 2` tempo em minutos para checar o arquivo de vídeo modificado. Dependendo do seu sistema, pode ser necessário aumentar.
- `"days_keep": 10` dias para manter os arquivos de vídeo, configure de acordo com seu espaço disponível.
- `"files_keep_temp": 8` arquivos para manter na pasta temporária, use sempre 2 x número de câmeras. Exemplo: 8 (cameras) * 2 = 16. Não use o mesmo numero de câmeras, pois pode ocorrer de ser movido arquivo que está sendo usado.
- `"path_completed": "/nvr/arquivos/"` pasta para arquivos definitivos.
- `"path_temp": "/nvr/raw/videos/"` pasta temporária / raw, não pode ser igual path_completed, nem path_log.
- `"path_log": "/nvr/logs/"` pasta para logs txt

## crontab
Se desejar alterar as configs, edite o arquivo `crontab` antes de iniciar o container.
- `/scripts/check.sh` padrão 2 minutos
- `/scripts/move.sh` padrão 5 minutos
- `/scripts/delete.sh` padrão 2 horas

# Iniciar o container
**Docker Compose**
<pre><code>services:
    nvr:
        container_name: nvr
        hostname: nvr
        restart: always
        stdin_open: true
        tty: true
        volumes:
            - /path arquivos video:/nvr
            - /path scripts:/scripts
        environment:
            - TZ=America/Sao_Paulo
        deploy:
            resources:
                limits:
                    memory: 512M
        command: ['/scripts/start.sh']
        image: alpine</code></pre>

**Docker CLI**
<pre><code>docker run -d -it \
  --name=nvr \
  -v /volume2/nvr:/nvr \
  -v /volume1/docker/nvr/scripts:/scripts \
  -e TZ=America/Sao_Paulo \
  alpine /scripts/start.sh</code></pre>

