#!/usr/bin/env python3.7

import iterm2
# This script was created with the "basic" environment which does not support adding dependencies
# with pip.

async def main(connection):
    # Your code goes here. Here's a bit of example code that adds a tab to the current window:
    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window
    if app.current_terminal_window is None:
        exit()

    fireball_directory = '~/fireball/services'


    async def run_command(command):
        session = app.current_terminal_window.current_tab.current_session
        await session.async_send_text(f'{command}\n')

    async def go_to_fireball():
        await run_command(f'cd {fireball_directory}')

    await window.current_tab.async_set_title('[ALL]')
    await go_to_fireball()
    # For some reason, no default port is working.
    await run_command('export PORT=3000')
    await run_command('OVERMIND_PROCFILE=Procfile.local overmind start -l web,rpc,go,worker,webpack,grabber,metrics -F $HOME/.tmux.conf.local -D')
    await run_command('overmind connect web')

    session = app.current_terminal_window.current_tab.current_session
    session2 = await session.async_split_pane(True)
    await session2.async_activate()
    await go_to_fireball()
    await run_command('overmind connect rpc')

    session3 = await session2.async_split_pane(True)
    await session3.async_activate()
    await go_to_fireball()
    await run_command('overmind connect worker')

    await window.async_create_tab()
    await window.current_tab.async_set_title('[WEB]')
    await go_to_fireball()
    await run_command('overmind connect web')

    await window.async_create_tab()
    await window.current_tab.async_set_title('[RPC]')
    await go_to_fireball()
    await run_command('overmind connect rpc')

    await window.async_create_tab()
    await window.current_tab.async_set_title('[WORKER]')
    await go_to_fireball()
    await run_command('overmind connect worker')

    await window.async_create_tab()
    await window.current_tab.async_set_title('[GO]')
    await go_to_fireball()
    await run_command('overmind connect go')

    await window.async_create_tab()
    await window.current_tab.async_set_title('[WEBPACK DEV SERVER]')
    await go_to_fireball()
    await run_command('overmind connect webpack')

    await session.async_activate()

iterm2.run_until_complete(main)
