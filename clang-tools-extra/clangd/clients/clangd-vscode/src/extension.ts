import * as vscode from 'vscode';
import * as vscodelc from 'vscode-languageclient';

/**
 *  this method is called when your extension is activate
 *  your extension is activated the very first time the command is executed
 */
export function activate(context: vscode.ExtensionContext) {
    // TODO: make this configurable
    const clangdPath = '/usr/bin/clangd';

    const serverOptions: vscodelc.ServerOptions = { command: clangdPath };

    const clientOptions: vscodelc.LanguageClientOptions = {
        // Register the server for C/C++ files
        documentSelector: ['c', 'cc', 'cpp', 'h', 'hh', 'hpp']
    };

    const clangdClient = new vscodelc.LanguageClient('Clang Language Server', serverOptions, clientOptions);

    console.log('Clang Language Server is now active!');

    const disposable = clangdClient.start();

    context.subscriptions.push(disposable);
}