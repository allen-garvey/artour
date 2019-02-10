const path = require('path');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const UglifyJsPlugin = require('uglifyjs-webpack-plugin');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');

module.exports = {
  optimization: {
    minimizer: [
      new UglifyJsPlugin({ cache: true, parallel: true, sourceMap: false }),
      new OptimizeCSSAssetsPlugin({})
    ]
  },
  entry: {
      admin: './web/static/js/admin/admin.js',
      app: './web/static/js/public/app.js',
  },
  output: {
    filename: '[name].min.js',
    path: path.resolve(__dirname, 'priv/static/js')
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader',
      },
      {
        test: /\.scss$/,
        use: [
                MiniCssExtractPlugin.loader,
                'css-loader',
                {
                  loader: 'sass-loader',
                  options: {
                      outputStyle: 'compressed',
                  },
                },
              ]
      }
    ]
  },
  plugins: [
    new VueLoaderPlugin(),
    new MiniCssExtractPlugin({ filename: '../css/[name].css' }),
  ]
};
