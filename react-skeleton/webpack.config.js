//----
//- ./webpack.config.js
//----
const path = require('path');

const HtmlWebpackPlugin = require('html-webpack-plugin');
const HtmlWebpackPluginConfig = new HtmlWebpackPlugin({
  template: './src/index.html',
  filename: 'index.html',
  inject: 'body'
})

module.exports = {
  //- Specifies the entry file where the bundler starts the bundling process.
  entry: './src/index.js',
  //- Specifies the location where the bundled Javascript code is to be saved.
  output: {
    path: path.resolve('dist'),
    filename: 'index_bundle.js'
  },
  module: {
    //- They are transformations that are applied on a file in our app.
    loaders: [
      { test: /\.js$/, loader: 'babel-loader', exclude: /node_modules/ },
      { test: /\.jsx$/, loader: 'babel-loader', exclude: /node_modules/ }
    ]
  },
  plugins: [HtmlWebpackPluginConfig]
}
