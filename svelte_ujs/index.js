class SvelteRailsUJS {
  static serverRender(component_name, props) {
    const requireComponent = require.context('components', true);
    const bundle = requireComponent('./' + component_name).default;
    const {html, css} = bundle.render(props);

    return `<style>${css.code}</style>` + html;
  }
}

// self.SvelteRailsUJS = SvelteRailsUJS

export default SvelteRailsUJS
