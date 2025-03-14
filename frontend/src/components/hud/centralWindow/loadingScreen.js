import { createComponent } from '/src/utils/component.js';

export const loadingScreen = createComponent({
	tag: 'loadingScreen',

	// Générer le HTML
	render: () => `
	<div id="loading-screen" class="d-flex justify-content-center align-items-center">
		<span class="loader"></span>
	</div>
	<style>

	.loader {
		position: relative;
		display: flex;
		align-items: center;
		justify-content: center;
		width: 100%;
		max-width: 6rem;
		margin-top: 3rem;
		height: 50vh;
		margin-bottom: 3rem;
	  }
	  .loader:before,
	  .loader:after {
		content: "";
		position: absolute;
		border-radius: 50%;
		animation: pulsOut 1.8s ease-in-out infinite;
		filter: drop-shadow(0 0 0.5rem rgba(255, 255, 255, 0.75));
	  }
	  .loader:before {
		width: 100%;
		padding-bottom: 100%;
		box-shadow: inset 0 0 0 0.5rem var(--primary-hud-elements-color);
		animation-name: pulsIn;
	  }
	  .loader:after {
		width: calc(100% - 1rem);
		padding-bottom: calc(100% - 1rem);
		box-shadow: 0 0 0 0 var(--primary-hud-elements-color);
	  }
	
	  @keyframes pulsIn {
		0% {
		  box-shadow: inset 0 0 0 0.5rem var(--primary-hud-elements-color);
		  opacity: 1;
		}
		50%, 100% {
		  box-shadow: inset 0 0 0 0 var(--primary-hud-elements-color);
		  opacity: 0;
		}
	  }
	
	  @keyframes pulsOut {
		0%, 50% {
		  box-shadow: 0 0 0 0 var(--primary-hud-elements-color);
		  opacity: 0;
		}
		100% {
		  box-shadow: 0 0 0 0.5rem var(--primary-hud-elements-color);
		  opacity: 1;
		}
	  }
		
	</style>
  `,
});
