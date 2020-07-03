<svelte:head>
	<title>Hello {name}! ❤</title>
</svelte:head>

<script>
  import { onMount } from 'svelte'

  export let name
  let time

  onMount(() => {
    const interval = setInterval(() => {
      time = new Date();
    }, 1000);

    return () => {
      clearInterval(interval);
    };
  });
</script>

<style>
  :global(body) {
    background-color: #223;
  }

  h1, code {
    color: #fee;
  }
</style>

<h1>Hello {name}! ❤</h1>

{#if time}
  <code>{time}</code>
{/if}
